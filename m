From: Meghana Madhyastha <meghana.madhyastha@gmail.com>
Subject: [PATCH v3 0/2] Chunk splitting of spi transfers
Date: Mon, 12 Mar 2018 09:53:30 +0000
Message-ID: <cover.1520848302.git.meghana.madhyastha@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: Mark Brown <broonie@kernel.org>,
 Daniel Vetter <daniel.vetter@intel.com>, linux-spi@vger.kernel.org,
 Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
 Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
List-Id: linux-spi.vger.kernel.org

LUNhbGwgc3BpX3NwbGl0X3RyYW5zZmVyc19tYXhzaXplIGluIF9fc3BpX3B1bXBfbWVzc2FnZXMK
dG8gc3BsaXQgbGFyZ2UgY2h1bmtzIGZvciBzcGkgZG1hIHRyYW5zZmVycy4KLVJlbW92ZSBjaHVu
ayBzcGxpdHRpbmcgaW4gdGhlIHRpbnlkcm0gc3BpIGhlbHBlciAoYXMgbm93IHRoZSBjb3JlIGlz
CmhhbmRsaW5nIHRoZSBjaHVuayBzcGxpdHRpbmcpLgoKQ2hhbmdlcyBpbiB2MzoKLVJlbW92ZSBt
YXhfY2h1bmsgCi1SZW1vdmUgdGlueWRybV9zcGlfbWF4X3RyYW5zZmVyX3NpemUoKSAgICAgICAg
ICAgICAgICAgICAgICAgIAotQ2hhbmdlIG1hc3Rlci0+bWF4X2RtYV9sZW4gaW4gcGF0Y2ggMC8y
IGFuZCBleHBsYWluIHdoeSBpdCBpcyBjaGFuZ2VkCgpNZWdoYW5hIE1hZGh5YXN0aGEgKDIpOgog
IHNwaTogU3BsaXQgc3BpIG1lc3NhZ2UgaW50byBjaHVua3Mgb2YgPDY1NTM1IGluIHRoZSBzcGkg
c3Vic3lzdGVtCiAgZHJtL3Rpbnlkcm06IFJlbW92ZSBjaHVuayBzcGxpdHRpbmcgaW4gdGlueWRy
bV9zcGlfdHJhbnNmZXIKCiBkcml2ZXJzL2dwdS9kcm0vdGlueWRybS9jb3JlL3Rpbnlkcm0taGVs
cGVycy5jIHwgODAgKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIGRyaXZlcnMvZ3B1L2RybS90
aW55ZHJtL21pcGktZGJpLmMgICAgICAgICAgICAgfCAxMCArLS0tCiBkcml2ZXJzL3NwaS9zcGkt
YmNtMjgzNS5jICAgICAgICAgICAgICAgICAgICAgIHwgMjIgKysrLS0tLQogMyBmaWxlcyBjaGFu
Z2VkLCAxNiBpbnNlcnRpb25zKCspLCA5NiBkZWxldGlvbnMoLSkKCi0tIAoyLjExLjAKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWls
aW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
