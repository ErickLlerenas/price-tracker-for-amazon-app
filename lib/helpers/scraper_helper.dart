import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';

Future<List> getPriceTitleImage(url) async {
  List priceTitleImage = [];
  double price;
  String title, img;

  //Scrap the URL
  var client = Client();
  Response response = await client.get(url);
  var document = parse(response.body);
  /************************* GET PRICE **************************/
  Element priceElement = document.querySelector('span#priceblock_dealprice');

  if (priceElement == null)
    priceElement = document.querySelector('span#priceblock_saleprice');
    
  if (priceElement == null)
    priceElement = document.querySelector('span#priceblock_ourprice');

  if (priceElement == null)
    priceElement = document.querySelector('span.a-color-price');

  if (priceElement == null) price = 0;

  if (priceElement != null)
    price = double.parse(
        priceElement.text.replaceFirst('\$', '').replaceAll(',', ''));

  priceTitleImage.add(price);

  /*************************** GET TITLE ************************/
  Element titleElement = document.querySelector('span#productTitle');
  if (titleElement != null)
    title = titleElement.text;
  else
    title = "";
  priceTitleImage.add(title);

  /************************* GET IMAGE *****************************/
  Element imageElement = document.querySelector('img#landingImage');
  if (imageElement != null) img = imageElement.attributes['src'];

  if (imageElement != null) {
    if (img.length > 500) {
      //In case Amazon img[src] returns data instead of a valid image URL
      imageElement = document.querySelector('img.sims-fbt-image');
      if (imageElement != null) {
        img = imageElement.attributes['src'].trim();
        img = img.replaceFirst('115', '500');
      }
    }
  }

  if (imageElement == null) {
    imageElement = document.querySelector('span.a-button-text > img');

    if (imageElement == null)
      imageElement = document.querySelector('div.imageThumb > img');

    if (imageElement != null) {
      img = imageElement.attributes['src'].trim();
      img = img.replaceFirst('115', '500');
      img = img.replaceFirst('40', '500');
      img = img.replaceFirst('38,50', '500');
      img = img.replaceFirst('SX60', 'SX500');
      img = img.replaceFirst('60,60', '500');
    }
  }
  if (imageElement == null) img = "";

  priceTitleImage.add(img);
  return priceTitleImage;
}
