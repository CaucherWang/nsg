//
// Created by 付聪 on 2017/6/21.
//

#include <efanna2e/index_nsg.h>
#include <efanna2e/util.h>
#include<iostream>
#include<algorithm>
#include<set>

void load_data(char* filename, float*& data, unsigned& num,
               unsigned& dim) {  // load data with sift10K pattern
  std::ifstream in(filename, std::ios::binary);
  if (!in.is_open()) {
    std::cout << "open file error" << std::endl;
    exit(-1);
  }
  in.read((char*)&dim, 4);
  std::cout << "data dimension: " << dim << std::endl;
  in.seekg(0, std::ios::end);
  std::ios::pos_type ss = in.tellg();
  size_t fsize = (size_t)ss;
  num = (unsigned)(fsize / (dim + 1) / 4);
  data = new float[num * dim * sizeof(float)];

  in.seekg(0, std::ios::beg);
  for (size_t i = 0; i < num; i++) {
    in.seekg(4, std::ios::cur);
    in.read((char*)(data + i * dim), dim * 4);
  }
  in.close();
}

std::vector<std::vector<int> > load_ground_truth(const char* filename) {
  std::ifstream in(filename, std::ios::binary);
  if (!in.is_open()) {
    std::cout << "open file error (in load_ground_truth)" << std::endl;
    exit(-1);
  }

  unsigned dim, num, real_dim;

  in.read((char*)&dim, 4);
  std::cout << "data dimension: " << dim << std::endl;
  real_dim = std::max(dim, 100u);
  std::cout << "read dimension: " << real_dim << std::endl;
  assert(dim >= real_dim);
  in.seekg(0, std::ios::end);
  std::ios::pos_type ss = in.tellg();
  size_t fsize = (size_t)ss;
  num = (unsigned)(fsize / (dim + 1) / 4);

  int* data = new int[num * real_dim * sizeof(int)];

  in.seekg(0, std::ios::beg);
  for (size_t i = 0; i < num; i++) {
    in.seekg(4, std::ios::cur);
    in.read((char*)(data + i * dim), real_dim * 4);
  }
  in.close();

  std::vector<std::vector<int> > res;
  for (int i = 0; i < num; i++) {
    std::vector<int> a;
    for (int j = i*dim; j < (i)*dim + real_dim; j++) {
      a.push_back(data[j]);
    //   std::cout << data[j] << ",";
    }
    // std::cout << std::endl;
    res.push_back(a);
  }

  return res;
}

void save_result(char* filename, std::vector<std::vector<unsigned> >& results) {
  std::ofstream out(filename, std::ios::binary | std::ios::out);

  for (unsigned i = 0; i < results.size(); i++) {
    unsigned GK = (unsigned)results[i].size();
    out.write((char*)&GK, sizeof(unsigned));
    out.write((char*)results[i].data(), GK * sizeof(unsigned));
  }
  out.close();
}

int recall(std::vector<unsigned> & query_res, std::vector<int> & gts, int K){
    int recall = 0;
    std::set<unsigned> cur_query_res_set(query_res.begin(), query_res.end());
    std::set<int> cur_query_gt(gts.begin(), gts.begin()+K);
    
    for (std::set<unsigned>::iterator x = cur_query_res_set.begin(); x != cur_query_res_set.end(); x++) { 
      std::set<int>::iterator iter = cur_query_gt.find(*x);
      if (iter != cur_query_gt.end()) {
        recall++;
      }
    }

  return recall;
}

static void test_performance(float* data_load, float* query_load, size_t vecsize, size_t qsize, efanna2e::IndexNSG& appr_alg, size_t vecdim,
               std::vector<std::vector<int> > &gts, size_t k, efanna2e::Parameters& paras) {
    double target_recall = 0.86;
    int lowk = ceil(k * (target_recall));
    std::vector<int>ret(qsize, 0);


    int index = 0;
#pragma omp parallel for
    for(int i = 0; i < qsize; ++i){
        bool flag = false;
        // if(i != 2504)
            // continue;
        #pragma omp critical
        {
            if(++index % 100 == 0)
                std::cerr << index << " / " << qsize << std::endl;
        }

        int lowef = k, highef, curef, tmp, bound = 40000;
        long success = -1;
        Measure measure;


        for(int _ = 0; _ < 1 && !flag; ++_){
            lowef = k; highef = bound;
            success = -1;
            while(lowef < highef){
                curef = (lowef + highef) / 2;

                measure.clear();

                std::vector<unsigned> answer(k);
                appr_alg.searchmeasure(query_load + i * vecdim, data_load, k, curef, answer, measure);

                tmp = recall(answer, gts[i], k);
                if(tmp < lowk){
                    lowef = curef+1;
                }else{
                    success = measure.ndc;
                    if(highef == curef)
                        break;
                    highef = curef;
                }
            }
            if(success >= 0){
                ret[i] = success;
                flag = true;
            } else if (tmp > lowk){
                ret[i] = measure.ndc;
                flag = true;
            }
            else if(tmp < lowk){
                // long large_NDC = measure.ndc;
                curef = highef;
                measure.clear();


                std::vector<unsigned> answer(k);
                appr_alg.SearchMeasure(query_load + i * vecdim, data_load, k, curef, answer, measure);

                tmp = recall(answer, gts[i], k);
                if(tmp >= lowk){
                    ret[i] = measure.ndc;
                    flag = true;
                }else if(curef >= bound){
                    std::cerr << i << std::endl;
                    ret[i] = measure.ndc;
                    flag = true;
                }
            }
        }
        if(!flag){
            std::cerr << i << std::endl;
            exit(-1);
        }
    }

    for(int i = 0; i < qsize; ++i){
        std::cout << ret[i] << ",";
    }
    std::cout << std::endl;
}



int main(int argc, char** argv) {
  if (argc != 7) {
    std::cout << argv[0]
              << " data_file query_file nsg_path search_K result_path"
              << std::endl;
    exit(-1);
  }
  float* data_load = NULL;
  unsigned points_num, dim;
  load_data(argv[1], data_load, points_num, dim);
  std::cout << "data path : " << argv[1] << std::endl;
  std::cout << "data num : " << points_num << " data dim : " << dim << std::endl;
  float* query_load = NULL;
  unsigned query_num, query_dim;
  load_data(argv[2], query_load, query_num, query_dim);
    std::cout << "query path : " << argv[2] << std::endl;
    std::cout << "query num : " << query_num << " query dim : " << query_dim << std::endl;
  assert(dim == query_dim);

  unsigned K = (unsigned)atoi(argv[4]);
  std::cout << "k: " << K << std::endl;

  std::string gtFileName = argv[5];
  std::vector<std::vector<int> > gts = load_ground_truth(gtFileName.c_str());
  std::cout << "ground truth path : " << gtFileName << std::endl;
  std::cout << "ground truth num : " << gts.size() << " ground truth dim : " << gts[0].size() << std::endl;


  // data_load = efanna2e::data_align(data_load, points_num, dim);//one must
  // align the data before build query_load = efanna2e::data_align(query_load,
  // query_num, query_dim);
  efanna2e::IndexNSG index(dim, points_num, efanna2e::L2, nullptr);
  std::cout << "L2 distance, index path: " << argv[3] << std::endl;
  index.Load(argv[3]);

  efanna2e::Parameters paras;

  std::string logFileName = argv[6];
  std::cout << "result path: "<< logFileName << std::endl;
  freopen(logFileName.c_str(), "a", stdout);

  test_performance(data_load, query_load, points_num, query_num, index, dim, gts, K, paras);

  return 0;
}
