
// 开发环境
import '../env.dart';

const SERVER_HOST_DEV = 'https://api.guaik.org/mock/158/airi';

// 生产环境
const SERVER_HOST_PROD = 'https://api.guaik.org/mock/158/airi';

const SERVER_API_URL = ENV == "DEV" ? SERVER_HOST_DEV : SERVER_HOST_PROD;
