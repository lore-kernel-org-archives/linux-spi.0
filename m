From: Kamal Dasu <kamal.dasu@broadcom.com>
Subject: Re: [PATCH v6,
 5/8] mtd: m25p80: Let m25p80_read() fallback to spi transfer
Date: Thu, 13 Oct 2016 17:15:08 -0400
Message-ID: <CAKekbesq1deU_0TCV4STAi=o8jZwoc_u+9zkdZuEhmd+BGwU2A@mail.gmail.com>
References: <1472076269-4731-1-git-send-email-kdasu.kdev@gmail.com>
 <1472076269-4731-6-git-send-email-kdasu.kdev@gmail.com>
 <4b3b3d3e-b3f8-1d5b-65e3-0c37b6a29096@gmail.com>
 <8309370e-f99f-ed51-4789-c1d97d9d8191@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Florian Fainelli <f.fainelli@gmail.com>, vigneshr@ti.com,
 Kamal Dasu <kdasu.kdev@gmail.com>, linux-spi@vger.kernel.org,
 Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>,
 Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
 bcm-kernel-feedback-list@broadcom.com, Jon Mason <jon.mason@broadcom.com>,
 Brian Norris <computersforpeace@gmail.com>
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <8309370e-f99f-ed51-4789-c1d97d9d8191@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

T24gTW9uLCBPY3QgMTAsIDIwMTYgYXQgNDoyOSBBTSwgQ3lyaWxsZSBQaXRjaGVuCjxjeXJpbGxl
LnBpdGNoZW5AYXRtZWwuY29tPiB3cm90ZToKPiBIaSBhbGwsCj4KPgo+IExlIDEwLzEwLzIwMTYg
w6AgMTA6MDQsIEZsb3JpYW4gRmFpbmVsbGkgYSDDqWNyaXQgOgo+PiBPbiAwOC8yNC8yMDE2IDAz
OjA0IFBNLCBLYW1hbCBEYXN1IHdyb3RlOgo+Pj4gSW4gbTI1cDgwX3JlYWQoKSBldmVuIHRob3Vn
aCBzcGlfZmxhc2hfcmVhZCgpIGlzIHN1cHBvcnRlZAo+Pj4gYnkgc29tZSBkcml2ZXJzLCB1bmRl
ciBjZXJ0YWluIGNpcmN1bXN0YW5jZXMgbGlrZSB1bmFsaWduZWQKPj4+IGJ1ZmZlciwgYWRkcmVz
cyBvciBhZGRyZXNzIHJhbmdlIGxpbWl0YXRpb25zIG9uIGNlcnRhaW4gU29Dcwo+Pj4gbGV0IGl0
IGZhbGxiYWNrIHRvIGNvcmUgc3BpIHJlYWRzLiBTdWNoIGRyaXZlcnMgYXJlIGV4cGVjdGVkCj4+
PiB0byByZXR1cm4gLUVBR0FJTiBzbyB0aGF0IHRoZSBtMjVwODBfcmVhZCgpIHVzZXMgc3RhbmRh
cmQKPj4+IHNwaSB0cmFuc2Zlci4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBLYW1hbCBEYXN1IDxr
ZGFzdS5rZGV2QGdtYWlsLmNvbT4KPj4KPj4gTVREIGZvbGtzLCBhbnkgY29tbWVudHMgb24gdGhp
cz8KPj4KPj4+IC0tLQo+Pj4gIGRyaXZlcnMvbXRkL2RldmljZXMvbTI1cDgwLmMgfCAxMSArKysr
KysrKystLQo+Pj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL2RldmljZXMvbTI1cDgwLmMgYi9k
cml2ZXJzL210ZC9kZXZpY2VzL20yNXA4MC5jCj4+PiBpbmRleCA5Y2Y3ZmNkLi43N2MyZDJjIDEw
MDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9tdGQvZGV2aWNlcy9tMjVwODAuYwo+Pj4gKysrIGIvZHJp
dmVycy9tdGQvZGV2aWNlcy9tMjVwODAuYwo+Pj4gQEAgLTE1NSw5ICsxNTUsMTYgQEAgc3RhdGlj
IHNzaXplX3QgbTI1cDgwX3JlYWQoc3RydWN0IHNwaV9ub3IgKm5vciwgbG9mZl90IGZyb20sIHNp
emVfdCBsZW4sCj4+PiAgICAgICAgICAgICAgbXNnLmRhdGFfbmJpdHMgPSBtMjVwODBfcnhfbmJp
dHMobm9yKTsKPj4+Cj4+PiAgICAgICAgICAgICAgcmV0ID0gc3BpX2ZsYXNoX3JlYWQoc3BpLCAm
bXNnKTsKPj4+IC0gICAgICAgICAgICBpZiAocmV0IDwgMCkKPj4+ICsKPj4+ICsgICAgICAgICAg
ICBpZiAocmV0ID49IDApCj4+PiArICAgICAgICAgICAgICAgICAgICByZXR1cm4gbXNnLnJldGxl
bjsKPj4+ICsKPj4+ICsgICAgICAgICAgICAvKgo+Pj4gKyAgICAgICAgICAgICAqIHNvbWUgc3Bp
IG1hc3RlciBkcml2ZXJzIG1pZ2h0IG5lZWQgdG8gZmFsbGJhY2sgdG8KPj4+ICsgICAgICAgICAg
ICAgKiBub3JtYWwgc3BpIHRyYW5zZmVyCj4+PiArICAgICAgICAgICAgICovCj4+PiArICAgICAg
ICAgICAgaWYgKHJldCAhPSAtRUFHQUlOKQo+IEkganVzdCB3b25kZXIgd2hldGhlciBFSU5WQUwg
d291bGQgYmUgYSBiZXR0ZXIgY2hvaWNlLgoKIHNwaV9mbGFzaF9yZWFkIGNhbGxzIHRoZSBkb3du
IHN0cmVhbSBjb250cm9sbGVyIGRyaXZlciB3aXRoIGFsbApwYXJhbXMgYWRkcmVzc2VzIGhvd2V2
ZXIgIGFjY2VsZXJhdGVkIHRyYW5zZmVyIGlzIG5vdCBwb3NzaWJsZSBieSB0aGUKY29udHJvbGxl
ciBkdWUgdG8gYWxpZ25tZW50IGlzc3VlcywgaXQgbmVlZHMgdG8gaW5kaWNhdGUgdG8gbTI1cCBj
YWxsCnRvIHRyeSB0aGUgbm9ybWFsIHRyYW5zZmVyLCBoZW5jZSB1c2Ugb2YgRUFHQUlOIHNlZW1l
ZCBhcHByb3ByaWF0ZS4KCgo+Pj4gICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsKPj4+
IC0gICAgICAgICAgICByZXR1cm4gbXNnLnJldGxlbjsKPj4+ICAgICAgfQo+Pj4KPj4+ICAgICAg
c3BpX21lc3NhZ2VfaW5pdCgmbSk7Cj4+Pgo+Pgo+Cj4gQmVzdCByZWdhcmRzLAo+Cj4gQ3lyaWxs
ZQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4IE1URCBkaXNjdXNzaW9uIG1haWxpbmcgbGlzdApodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW10ZC8K
