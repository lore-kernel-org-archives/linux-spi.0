From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [RFC net-next 00/15] net: A socket API for LoRa
Date: Wed, 4 Jul 2018 20:26:13 +0200
Message-ID: <487df785-ddf5-ed81-a253-6afb7f2de811@datenfreihafen.org>
References: <20180701110804.32415-1-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: =?UTF-8?Q?Michal_Kube=c4=8dek?= <mkubecek@suse.cz>,
 =?UTF-8?Q?Konstantin_B=c3=b6hm?= <konstantin.boehm@ancud.de>,
 contact@snootlab.com, Ken Yu <ken.yu@rakwireless.com>,
 =?UTF-8?Q?Michael_R=c3=b6der?= <michael.roeder@avnet.eu>,
 Rob Herring <robh@kernel.org>, lora@globalsat.com.tw,
 Alexander Graf <agraf@suse.de>, Jan Jongboom <jan.jongboom@arm.com>,
 Janus Piwek <jpiwek@arroweurope.com>, Jon Ortego <Jon.Ortego@imst.de>,
 Jian-Hong Pan <starnight@g.ncu.edu.tw>, devicetree@vger.kernel.org,
 Jiri Pirko <jiri@resnulli.us>, Marcel Holtmann <marcel@holtmann.org>,
 Mark Brown <broonie@kernel.org>, Dollar Chen <dollar.chen@wtmec.com>,
 Brian Ray <brian.ray@link-labs.com>, linux-arm-kernel@lists.infradead.org,
 lora@radioshuttle.de, Matthias Brugger <mbrugger@suse.com>,
 Ben Whitten <ben.whitten@lairdtech.com>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Steve deRosier <deros
To: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, netdev@vger.kernel.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180701110804.32415-1-afaerber@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

SGVsbG8uCgpPbiAwMS4wNy4yMDE4IDEzOjA3LCBBbmRyZWFzIEbDpHJiZXIgd3JvdGU6Cj4gCj4g
VGhpcyBwYXRjaHNldCwgdXBkYXRlZCBmcm9tIDIwMTcgYW5kIGV4dGVuZGVkLCBpcyBpbXBsZW1l
bnRpbmcga2VybmVsIGRyaXZlcnMKPiBmb3IgdmFyaW91cyBMb1JhIGNoaXBzZXRzIGFuZCBtb2R1
bGVzLgoKSSBhbSB2ZXJ5IGhhcHB5IHRvIHNlZSB0aGF0IHdlIG5vdyBoYXZlIHRocmVlIHBlb3Bs
ZSAoeW91LCBKaWFuLUhvbmcgYW5kCkJlbikgd29ya2luZyB0b3dhcmRzIGEgbG9yYSBzdWJzeXN0
ZW0gZm9yIHByb3RvY29sIHN0YWNrIGFuZCBkcml2ZXJzLgoKV2lsbCBhbGxvY2F0ZSBzb21lIHRp
bWUgdG8gbG9vayBvdmVyIHRoaXMgYW5kIHByb3ZpZGUgc29tZSByZXZpZXcgYW5kCmZlZWRiYWNr
IGhvdyB3ZSBoYW5kbGVkIHRoaW5ncyBpbiB0aGUgaWVlZTgwMjE1NCBhbmQgNmxvd3BhbiBzdWJz
eXN0ZW1zLgoKV2UgYXJlIGFsc28gaGF2aW5nIGEgSW9UIHByb3RvY29scyB3b3Jrc2hvcCBkdXJp
bmcgTmV0RGV2IENvbmYgbmV4dCB3ZWVrCmluIE1vbnRyZWFsIChzaG9ydCBub3RpY2UgaWYgeW91
IGFyZSBub3QgYWxyZWFkeSBwbGFubmluZyB0byBhdHRlbmQpLiBJZgp5b3UgKG9yIEJlbikgaGFz
IHNvZW0gdG9waWNzIHdhbnRlZCB0byBicmluZyB1cCB0aGVpciBwbGVhc2UgbGV0IG1lIGtub3cK
YnkgcG0uIEppYW4tSG9uZyB3aWxsIGJlIHRoZXJlIHByZXNlbnRpbmcgb24gaGlzIGxvcmEgd29y
ayBhbmQgSSB3b3VsZApsb3ZlIHRvIGdldCBtb3JlIGlucHV0IGZyb20geW91IGFuZCBCZW4gb24g
eW91ciB2aWV3cyBvbiB0aGlzLgoKaHR0cHM6Ly9uZXRkZXZjb25mLm9yZy8weDEyL3Nlc3Npb24u
aHRtbD93b3Jrc2hvcC1vbi1pb3QtcmVsYXRlZC1tYWMtbGF5ZXJzLWhlYWRlci1jb21wcmVzc2lv
bi1hbmQtcm91dGluZy1wcm90b2NvbHMKCnJlZ2FyZHMKU3RlZmFuIFNjaG1pZHQKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
