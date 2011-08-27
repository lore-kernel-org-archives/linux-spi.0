From: "Xu, Chao" <chao.xu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: FW: [Bug 40302] spi master's parent device node 's reference count
	is not decreased
Date: Sat, 27 Aug 2011 09:15:58 +0800
Message-ID: <A24AE1FFE7AEC5489F83450EE98351BF420B957AE7@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_A24AE1FFE7AEC5489F83450EE98351BF420B957AE7shsmsx502ccrc_"
Cc: "Xu, Chao" <chao.xu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: "dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--_002_A24AE1FFE7AEC5489F83450EE98351BF420B957AE7shsmsx502ccrc_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQpUaGVyZSBhcmUgdHdvIGJ1Z3MgaW4gZHJpdmVyL3NwaS9zcGljLg0KDQooMSkgd2hlbiBzcGkg
bWFzdGVyIGlzIGRlY29uc3RydWN0ZWQsIGl0J3MgcGFyZW50IGRldmljZSBub2RlJ3MgcmVmZXJl
bmNlIGNvdW50DQppcyBub3QgZGVjcmVhc2VkLiBJdCBleGlzdHMgZnJvbSBrZXJuZWwgMi42LjI4
IHRvIDMuMC4gSXQgc29tZXRpbWVzIHJlc3VsdHMgaW4NCm1lbW9yeSBsZWFrLiBFeGFtcGxlLCBp
dHMncyBwYXJlbnQgZGV2aWNlIG5vZGUgd2lsbCBiZSBhbHdheXMgcmVmZXJlbmNlIGJ5DQpvdGhl
cnMgYW5kIG5ldmVyIGJlIHJlbGVhc2VkLg0KDQooMikgd2hlbiBzcGkgZGV2aWNlIGlzIGNyZWF0
ZWQsIGl0cyBwYXJlbnQgZGV2aWNlIG5vZGUgc2hvdWxkIGJlIHNwaSBtYXN0ZXIuIEl0DQpzaG91
bGQgYmUga2VlcCBjb25zaXN0ZW50IHdpdGggZnVuY3Rpb24gc3BpX3VucmVnaXN0ZXJfbWFzdGVy
LiBpdCBleGlzdHMgaW4NCjIuNi4zOSBhbmQgMy4wDQoNCg0KQi4gUi4NCkNoYW8gWHUNCkRpZ2l0
YWwgSG9tZSBHcm91cA0KSW50ZWwgQ29ycG9yYXRpb24NClRlbDogICA4Ni0yMS02MTE2LTczODYN
CkluZXQ6ICA4ODIxLTczODYNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGJ1
Z3ppbGxhLWRhZW1vbkBidWd6aWxsYS5rZXJuZWwub3JnIFttYWlsdG86YnVnemlsbGEtZGFlbW9u
QGJ1Z3ppbGxhLmtlcm5lbC5vcmddIA0KU2VudDogU2F0dXJkYXksIEF1Z3VzdCAyNywgMjAxMSA3
OjIwIEFNDQpUbzogWHUsIENoYW8NClN1YmplY3Q6IFtCdWcgNDAzMDJdIHNwaSBtYXN0ZXIncyBw
YXJlbnQgZGV2aWNlIG5vZGUgJ3MgcmVmZXJlbmNlIGNvdW50IGlzIG5vdCBkZWNyZWFzZWQNCg0K
aHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD00MDMwMg0KDQoNCkFu
ZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+IGNoYW5nZWQ6DQoNCiAgICAg
ICAgICAgV2hhdCAgICB8UmVtb3ZlZCAgICAgICAgICAgICAgICAgICAgIHxBZGRlZA0KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KICAgICAgICAgICAgICAgICBDQ3wgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmcNCg0KDQoNCg0KLS0tIENvbW1lbnQgIzEg
ZnJvbSBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPiAgMjAxMS0wOC0y
NiAyMzoyMDoxNyAtLS0NClBsZWFzZSBkb24ndCBzZW5kIHBhdGNoZXMgdmlhIGJ1Z3ppbGxhIC0g
aXQgY2F1c2VzIGxvdHMgb2YgcHJvYmxlbXMgd2l0aA0Kb3VyIHVzdWFsIHBhdGNoIG1hbmFnZW1l
bnQgYW5kIHJldmlldyBwcm9jZXNzZXMuDQoNClBsZWFzZSBzZW5kIHRoaXMgcGF0Y2ggdmlhIGVt
YWlsIGFzIHBlciBEb2N1bWVudGF0aW9uL1N1Ym1pdHRpbmdQYXRjaGVzLiANClN1aXRhYmxlIHJl
Y2lwaWVudHMgbWF5IGJlIGZvdW5kIHZpYSBzY3JpcHRzL2dldF9tYWludGFpbmVyLnBsLiAgUGxl
YXNlDQphbHNvIGNjIG15c2VsZiBvbiB0aGUgZW1haWwuDQoNClRoYW5rcy4NCg0KLS0gDQpDb25m
aWd1cmUgYnVnbWFpbDogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3VzZXJwcmVmcy5jZ2k/
dGFiPWVtYWlsDQotLS0tLS0tIFlvdSBhcmUgcmVjZWl2aW5nIHRoaXMgbWFpbCBiZWNhdXNlOiAt
LS0tLS0tDQpZb3UgYXJlIG9uIHRoZSBDQyBsaXN0IGZvciB0aGUgYnVnLg0KWW91IHJlcG9ydGVk
IHRoZSBidWcuDQo=

--_002_A24AE1FFE7AEC5489F83450EE98351BF420B957AE7shsmsx502ccrc_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
EMC VNX: the world's simplest storage, starting under $10K
The only unified storage solution that offers unified management 
Up to 160% more powerful than alternatives and 25% more efficient. 
Guaranteed. http://p.sf.net/sfu/emc-vnx-dev2dev
--_002_A24AE1FFE7AEC5489F83450EE98351BF420B957AE7shsmsx502ccrc_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--_002_A24AE1FFE7AEC5489F83450EE98351BF420B957AE7shsmsx502ccrc_--
