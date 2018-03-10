From: Meghana Madhyastha <meghana.madhyastha@gmail.com>
Subject: [PATCH v2 0/2] Chunk splitting of spi transfers
Date: Sat, 10 Mar 2018 15:50:48 +0000
Message-ID: <cover.1520691344.git.meghana.madhyastha@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: Mark Brown <broonie@kernel.org>,
 Daniel Vetter <daniel.vetter@intel.com>, linux-spi@vger.kernel.org,
 Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
 Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org,
 kernel@martin.sperl.org
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
CmhhbmRsaW5nIHRoZSBjaHVuayBzcGxpdHRpbmcpLgoKQ2hhbmdlcyBpbiB2MjoKLUNoYW5nZSB0
aGUgb3JkZXIgb2YgdGhlIHR3byBwYXRjaGVzIGluIHRoZSBwYXRjaHNldC4KLVVuZG8gdGhlIHNw
dXJpb3VzIGJsYW5rIGxpbmUgZGVsZXRpb25zCi1SZW1vdmUgYmNtMjgzNV9zcGlfdHJhbnNmZXJf
b25lX21lc3NhZ2UgYW5kIGFkZCBzcGlfc3BsaXRfdHJhbnNmZXJzX21heHNpemUKIGluIF9fc3Bp
X3B1bXBfbWVzc2FnZXMuIFRoaXMgc29sdmVzIHRoZSBETUEgdGltZSBvdXQgZXJyb3IuCgpNZWdo
YW5hIE1hZGh5YXN0aGEgKDIpOgogIHNwaTogU3BsaXQgc3BpIG1lc3NhZ2UgaW50byBjaHVua3Mg
b2YgPDY1NTM1IGluIHRoZSBzcGkgc3Vic3lzdGVtCiAgZHJtL3Rpbnlkcm06IFJlbW92ZSBjaHVu
ayBzcGxpdHRpbmcgaW4gdGlueWRybV9zcGlfdHJhbnNmZXIKCiBkcml2ZXJzL2dwdS9kcm0vdGlu
eWRybS9jb3JlL3Rpbnlkcm0taGVscGVycy5jIHwgNDggKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KIGRyaXZlcnMvZ3B1L2RybS90aW55ZHJtL21pcGktZGJpLmMgICAgICAgICAgICAgfCAxMCAr
Ky0tLS0KIGRyaXZlcnMvc3BpL3NwaS1iY20yODM1LmMgICAgICAgICAgICAgICAgICAgICAgfCAx
NSArLS0tLS0tLQogZHJpdmVycy9zcGkvc3BpLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICA4ICsrKysrCiA0IGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDY0IGRlbGV0
aW9ucygtKQoKLS0gCjIuMTEuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
ZHJpLWRldmVsCg==
