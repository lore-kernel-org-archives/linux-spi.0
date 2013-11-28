From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH 00/23] mtd: st_spi_fsm: Add new device
Date: Thu, 28 Nov 2013 11:34:29 +0800
Message-ID: <5296B9C5.3060704@freescale.com>
References: <1385137380-28968-1-git-send-email-lee.jones@linaro.org>
 <20131127040723.GZ9468@ld-irv-0074.broadcom.com>
 <20131127115226.GC3296@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Cc: angus.clark@st.com, linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-mtd@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>,
 dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20131127115226.GC3296@lee--X1>
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

5LqOIDIwMTPlubQxMeaciDI35pelIDE5OjUyLCBMZWUgSm9uZXMg5YaZ6YGTOgo+IEhvd2V2ZXIs
IGFzIHdlIHNlbmQgZW50aXJlICdtZXNzYWdlIHNlcXVlbmNlcycgdG8gdGhlIEZTTSBDb250cm9s
bGVyCj4gYXMgb3Bwb3NlZCB0byBtZXJlbHkgT1BDT0RFcyB3ZSB3b3VsZCBoYXZlIHRvIGV4dHJh
Y3QgdGhlIE9QQ09ERSBmcm9tCj4gZmxhc2gtPmNvbW1hbmRbMF0gYW5kIGNhbGwgb3VyIG93biBm
dW5jdGlvbnMgdG8gY3JhZnQgdGhlIGNvcnJlY3QKPiAnbWVzc2FnZSBzZXF1ZW5jZScgZm9yIHRo
ZSB0YXNrLiBGb3IgdGhpcyByZWFzb24gd2UgcmVqZWN0ZWQgdGhlIGlkZWEKPiBhbmQgd2VudCB3
aXRoIGEgc3RhbmQtYWxvbmUgZHJpdmVyLgo+CmNvdWxkIHlvdSBzZW5kIG1lIHRoZSBkYXRhc2hl
ZXQgb2YgeW91ciBzcGkgbm9yIGNvbnRyb2xsZXI/CkkgY2FuIGNoYW5nZSBteSBjb2RlIGlmIGl0
IHJlYWxseSBub3QgZ29vZCBlbm91Z2guCgp3ZSBjYW4gc3RvcmUgdGhlIG9wY29kZSB0byBhIGZp
ZWxkLCBzdWNoIGFzIHNwaV9ub3Jfd3JpdGVfb3AuCj4gVGhlIGZyYW1ld29yayB3aGljaCBIdWFu
ZyBpcyBwcm9wb3Npbmcgc3VmZmVycyBmcm9tIHRoZSBzYW1lIGlzc3Vlcy4KPiBPbmx5IHByb3Zp
ZGluZyByZWFkKCksIHdyaXRlKCksIHJlYWRfcmVnKCkgYW5kIHdyaXRlX3JlZygpIGRvZXNuJ3QK
PiB3b3JrIGZvciBvdXIgdXNlLWNhc2UsIGFzIHdlJ2QgaGF2ZSB0byBkZWNvZGUgdGhlIGZsYXNo
LT5jb21tYW5kWzBdIGFuZAo+IGludm9rZSBvdXIgb3duIGludGVybmFsIHJvdXRpbmVzIGFzIGJl
Zm9yZS4KPgo+IFRoZSBvbmx5IGZyYW1ld29yayB3aXRoIHdvdWxkIHdvcmsgZm9yIHVzIHdvdWxk
IGNvbnNpc3QgYWxtb3N0IGFsbAo+IG9mIHRoZSBpbXBvcnRhbnQgZnVuY3Rpb25zIHN1Y2ggYXM7
IHJlYWQoKSwgd3JpdGUoKSwgZXJhc2UoKSwKPiB3YWl0X2J1c3koKSwgcmVhZF9qZWRlYygpLCBy
ZWFkX3N0YXR1c19yZWcoKSwgd3JpdGVfc3RhdHVzX3JlZygpLAo+IHJlYWRfY29udHJvbF9yZWco
KSwgd3JpdGVfY29udHJvbF9yZWcoKSwgZXRjLiBIb3dldmVyLCB0aGlzIGFwcHJvYWNoCj4gICAK
cmVhZF9qZWRlYygpIGNhbiBiZSByZXBsYWNlZCBieSByZWFkX3JlZygweDlmKTsKCnJlYWRfc3Rh
dHVzKCkgY2FuIGJlIHJlcGxhY2VkIGJ5IHJlYWRfcmVnKDB4NSk7CgouLi4uCgp3cml0ZV9jb250
cm9sX3JlZygpIGNhbiBiZSByZXBsYWNlZCBieSB3cml0ZV9yZWcoeHgpLgoKClBsZWFzZSBjb3Jy
ZWN0IG1lIGlmIGkgYW0gd3JvbmcuCgpJTUhPLCB0aGUgY3VycmVudCBmb3VyIGhvb2tzIGZvciBz
cGktbm9ye30gY2FuIGRvIGFsbCB0aGUgdGhpbmdzLgoKICAgICAgcmVhZC93cml0ZS9yZWFkX3Jl
Zy93cml0ZV9yZWcuCgp0aGFua3MKSHVhbmcgU2hpamllCgoKCgoKCgoKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXggTVREIGRpc2N1
c3Npb24gbWFpbGluZyBsaXN0Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtbXRkLwo=
