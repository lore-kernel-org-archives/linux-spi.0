From: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Subject: Re: [PATCH v5 1/1] davinci: spi: replace existing driver
Date: Wed, 06 Oct 2010 23:55:14 -0400
Message-ID: <4CAD44A2.8080008@criticallink.com>
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
	<B85A65D85D7EB246BE421B3FB0FBB59302342050C7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
        Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302342050C7-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

SGkgU2VraGFyLAoKT24gMTAvMDYvMjAxMCAxMTozNyBBTSwgTm9yaSwgU2VraGFyIHdyb3RlOgo+
IEhpIE1pa2UsCj4gCj4gT24gTW9uLCBTZXAgMjAsIDIwMTAgYXQgMjM6MTI6NTMsIE1pY2hhZWwg
V2lsbGlhbXNvbiB3cm90ZToKPj4KPj4gTGV0IG1lIGtub3cgaWYgeW91IHdhbnQgdGVzdGluZyBv
biB0aGUgRE1BIHBvcnRpb24gb2YgdGhlIHBhdGNoICh3aGVuIHlvdXIgcmVhZHksIG9mIGNvdXJz
ZSkuCj4gCj4gSSBqdXN0IGZpbmlzaGVkIHB1c2hpbmcgdGhlIERNQSByZWxhdGVkIHBhdGNoZXMg
dG8gdGhlIGdpdCBicmFuY2hbMV0uCj4gSSBoYXZlIG5vdCB0ZXN0ZWQgeWV0LCBidXQgZmVlbCBm
cmVlIHRvIGdpdmUgaXQgYSBnbyAobWF5YmUgSSB3aWxsIGdldAo+IGx1Y2t5IGFnYWluISkuCj4g
Cj4gQWxzbywgZG8geW91IGhhdmUgcGF0Y2hlcyBhZGRpbmcgU1BJIHN1cHBvcnQgZm9yIERBODUw
IHBsYXRmb3JtPwo+IEkgY2FuIGluY2x1ZGUgdGhlc2UgcGF0Y2hlcyBvbiB0aGlzIGJyYW5jaCBz
byBvdGhlcnMgd2hvIHdpbGwgYmUKPiB0ZXN0aW5nIGRvbuKAmXQgaGF2ZSB0byByZXBlYXQgdGhl
IHdvcmsuCj4gCj4gVGhhbmtzLAo+IFNla2hhcgo+IAo+IFsxXSBodHRwOi8vYXJhZ28tcHJvamVj
dC5vcmcvZ2l0L3Byb2plY3RzLz9wPWxpbnV4LWRhdmluY2kuZ2l0O2E9c2hvcnRsb2c7aD1yZWZz
L2hlYWRzL2RhdmluY2ktc3BpLXJld3JpdGUKPiAKCkdyZWF0IG5ld3MuICBJJ2xsIHRyeSB0byBn
aXZlIGl0IGEgc3BpbiBiZWZvcmUgdGhlIHdlZWtlbmQuICBJIGRvIGhhdmUgYSBwYXRjaCBmb3Ig
dGhlIE1pdHlEU1AtTDEzOCAoZGE4NTAgCmJhc2VkKSwgSSBjb3VsZCBwcm9wb3NlIGEgcGF0Y2gg
c2V0IGZvciB0aGUgZGE4NTAtZXZtIChib3RoIHVzZSB0aGUgc2FtZSBTUEktTk9SIGRldmljZSwg
c2FtZSBTUEkgcG9ydCBhbmQgCmNoaXAgc2VsZWN0KS4gSSBuZWVkIHRvIHNlcGFyYXRlIGl0IG91
dCBmcm9tIHNvbWUgb3RoZXIgd29yaywgYW5kIEknbSBhIGxpdHRsZSBibGVhcnkgZXllZCByaWdo
dApub3cuICBJdCdzIHByZXR0eSBzdHJhaWdodGZvcndhcmQsIHRob3VnaC4KCldlJ3ZlIGFsc28g
Z290IGEgY291cGxlIG9mIG90aGVyIGRldmljZXMgdGhhdCB3ZSBjYW4gdGlua2VyIHdpdGggYXMg
d2VsbCAoYSBjb3VwbGUgb2YgZGlmZmVyZW50IFNQSS9DQU4gCmludGVyZmFjZSBjaGlwcykuICBJ
J2xsIGxldCB5b3Uga25vdyB3aGF0IHdlIGZpbmQuCgpUaGFua3MgZm9yIGhhbW1lcmluZyB0aGlz
IG91dC4KCi1NaWtlCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KRGF2aW5jaS1saW51eC1vcGVuLXNvdXJjZSBtYWlsaW5nIGxpc3QKRGF2aW5jaS1saW51
eC1vcGVuLXNvdXJjZUBsaW51eC5kYXZpbmNpZHNwLmNvbQpodHRwOi8vbGludXguZGF2aW5jaWRz
cC5jb20vbWFpbG1hbi9saXN0aW5mby9kYXZpbmNpLWxpbnV4LW9wZW4tc291cmNlCg==
