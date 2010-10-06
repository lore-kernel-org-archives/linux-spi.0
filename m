From: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v5 1/1] davinci: spi: replace existing driver
Date: Wed, 6 Oct 2010 21:07:43 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302342050C7@dbde02.ent.ti.com>
References: <1280355490-11878-1-git-send-email-bniebuhr@efjohnson.com>
	<4C8EB795.1080607@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6DF4C95@dbde02.ent.ti.com>
	<201009140904.59555.caglarakyuz@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6DF4D9B@dbde02.ent.ti.com>
	<4C8F7460.6050006@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6DF50C1@dbde02.ent.ti.com>
	<4C94B9BD.4010606@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6F5385B@dbde02.ent.ti.com>
	<4C979D1D.1070707@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org"
	<davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
	Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Caglar Akyuz <caglarakyuz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4C979D1D.1070707-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
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

SGkgTWlrZSwNCg0KT24gTW9uLCBTZXAgMjAsIDIwMTAgYXQgMjM6MTI6NTMsIE1pY2hhZWwgV2ls
bGlhbXNvbiB3cm90ZToNCj4NCj4gTGV0IG1lIGtub3cgaWYgeW91IHdhbnQgdGVzdGluZyBvbiB0
aGUgRE1BIHBvcnRpb24gb2YgdGhlIHBhdGNoICh3aGVuIHlvdXIgcmVhZHksIG9mIGNvdXJzZSku
DQoNCkkganVzdCBmaW5pc2hlZCBwdXNoaW5nIHRoZSBETUEgcmVsYXRlZCBwYXRjaGVzIHRvIHRo
ZSBnaXQgYnJhbmNoWzFdLg0KSSBoYXZlIG5vdCB0ZXN0ZWQgeWV0LCBidXQgZmVlbCBmcmVlIHRv
IGdpdmUgaXQgYSBnbyAobWF5YmUgSSB3aWxsIGdldA0KbHVja3kgYWdhaW4hKS4NCg0KQWxzbywg
ZG8geW91IGhhdmUgcGF0Y2hlcyBhZGRpbmcgU1BJIHN1cHBvcnQgZm9yIERBODUwIHBsYXRmb3Jt
Pw0KSSBjYW4gaW5jbHVkZSB0aGVzZSBwYXRjaGVzIG9uIHRoaXMgYnJhbmNoIHNvIG90aGVycyB3
aG8gd2lsbCBiZQ0KdGVzdGluZyBkb27igJl0IGhhdmUgdG8gcmVwZWF0IHRoZSB3b3JrLg0KDQpU
aGFua3MsDQpTZWtoYXINCg0KWzFdIGh0dHA6Ly9hcmFnby1wcm9qZWN0Lm9yZy9naXQvcHJvamVj
dHMvP3A9bGludXgtZGF2aW5jaS5naXQ7YT1zaG9ydGxvZztoPXJlZnMvaGVhZHMvZGF2aW5jaS1z
cGktcmV3cml0ZQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KQmVhdXRpZnVsIGlzIHdyaXRpbmcg
c2FtZSBtYXJrdXAuIEludGVybmV0IEV4cGxvcmVyIDkgc3VwcG9ydHMKc3RhbmRhcmRzIGZvciBI
VE1MNSwgQ1NTMywgU1ZHIDEuMSwgIEVDTUFTY3JpcHQ1LCBhbmQgRE9NIEwyICYgTDMuClNwZW5k
IGxlc3MgdGltZSB3cml0aW5nIGFuZCAgcmV3cml0aW5nIGNvZGUgYW5kIG1vcmUgdGltZSBjcmVh
dGluZyBncmVhdApleHBlcmllbmNlcyBvbiB0aGUgd2ViLiBCZSBhIHBhcnQgb2YgdGhlIGJldGEg
dG9kYXkuCmh0dHA6Ly9wLnNmLm5ldC9zZnUvYmVhdXR5b2Z0aGV3ZWIKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Kc3BpLWRldmVsLWdlbmVyYWwgbWFpbGlu
ZyBsaXN0CnNwaS1kZXZlbC1nZW5lcmFsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xp
c3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9zcGktZGV2ZWwtZ2VuZXJhbAo=
