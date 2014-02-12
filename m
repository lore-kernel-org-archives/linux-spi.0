From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH] spi: Remove duplicate code to check chip_select
Date: Wed, 12 Feb 2014 08:22:31 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF2B18305265@HQMAIL01.nvidia.com>
References: <~B52fa2ebe0000.52fb9e150000.0008.mml.2407171955@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>,
	Thomas Langer <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>,
	Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <~B52fa2ebe0000.52fb9e150000.0008.mml.2407171955@phoenix>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

QXhlbCBMaW4gd3JvdGUgYXQgVHVlc2RheSwgRmVicnVhcnkgMTEsIDIwMTQgNzowOCBBTToNCj4g
SW4gc3BpX2FkZF9kZXZpY2UoKSwgd2UgaGF2ZSB0aGUgY29kZSB0byB2YWxpZGF0ZSBzcGktPmNo
aXBfc2VsZWN0Lg0KPiBTbyByZW1vdmUgdGhlIGR1cGxpY2F0ZSBjb2RlIGluIHZhcmlvdXMgZHJp
dmVycy4NCg0KRm9yIHRoZSBUZWdyYSBkcml2ZXJzLA0KQWNrZWQtYnk6IFN0ZXBoZW4gV2FycmVu
IDxzd2FycmVuQG52aWRpYS5jb20+DQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpUaGlz
IGVtYWlsIG1lc3NhZ2UgaXMgZm9yIHRoZSBzb2xlIHVzZSBvZiB0aGUgaW50ZW5kZWQgcmVjaXBp
ZW50KHMpIGFuZCBtYXkgY29udGFpbg0KY29uZmlkZW50aWFsIGluZm9ybWF0aW9uLiAgQW55IHVu
YXV0aG9yaXplZCByZXZpZXcsIHVzZSwgZGlzY2xvc3VyZSBvciBkaXN0cmlidXRpb24NCmlzIHBy
b2hpYml0ZWQuICBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ug
Y29udGFjdCB0aGUgc2VuZGVyIGJ5DQpyZXBseSBlbWFpbCBhbmQgZGVzdHJveSBhbGwgY29waWVz
IG9mIHRoZSBvcmlnaW5hbCBtZXNzYWdlLg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg==
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
