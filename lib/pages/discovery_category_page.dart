import 'package:flutter/material.dart';
import 'package:ty/model/bean/category_bean.dart';
import 'package:ty/model/discovery_model.dart';
import 'package:ty/pages/category_detail_page.dart';
import 'package:ty/utils/m_log.dart';
import 'package:ty/utils/toast_util.dart';
import 'package:ty/widget/loading_container.dart';

///分类页面
class DiscoveryCategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DiscoveryCategoryPageState();
}

class DiscoveryCategoryPageState extends State<DiscoveryCategoryPage>
    with AutomaticKeepAliveClientMixin {
  DiscoveryModel discoveryModel = DiscoveryModel();
  bool _isLoading = true;
  List<CategoryBean> categoryBeans = [];

  @override
  void initState() {
    super.initState();

    _queryCategoryData();
  }

  void _queryCategoryData() {
    discoveryModel.getCategory().then((result) {
      setState(() {
        _isLoading = false;
        categoryBeans = result;
      });
    }).catchError((e) {
      setState(() {
        _isLoading = false;
      });
      MLog.log(e);
      JudyToast.showToast("加载分类数据出错！");
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    return LoadingContainer(
        isLoading: _isLoading,
        child: GridView.builder(
            padding: EdgeInsets.only(top: 4, bottom: 4 + mq.padding.bottom),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                childAspectRatio: 0.9),
            itemCount: categoryBeans.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildItem(context, index);
            }));
  }

  Widget _buildItem(BuildContext context, int index) {
    CategoryBean categoryBean = categoryBeans[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return CategoryDetailPage(categoryBean);
        }));
      },
      child: Container(
        height: 200,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                FadeInImage.assetNetwork(
                  placeholder: "images/placeholder_banner.png",
                  image: categoryBean.bgPicture,
                  fit: BoxFit.fill,
                ),
                Container(decoration: BoxDecoration(color: Color(0x30000000))),
                Center(
                  child: Text("#${categoryBean.name}",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                )
              ],
            )),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
