// 开发环境
import '../env.dart';

const SERVER_HOST_DEV = 'http://xieyezi.com:9003/mock/9/daily';

// 生产环境
const SERVER_HOST_PROD = 'http://xieyezi.com:9003/mock/9/daily';

const SERVER_API_URL = ENV == "DEV" ? SERVER_HOST_DEV : SERVER_HOST_PROD;
