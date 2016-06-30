From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 6/6] spi: st-ssc4: Remove 'no clocking' hack
Date: Thu, 30 Jun 2016 21:52:15 +0100
Message-ID: <20160630205215.GF1707@dell>
References: <20160607111930.10375-1-lee.jones@linaro.org>
 <20160607111930.10375-7-lee.jones@linaro.org>
 <20160607151712.GA7510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: kernel@stlinux.com, mturquette@baylibre.com, sboyd@codeaurora.org,
 patrice.chotard@st.com, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, maxime.coquelin@st.com
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160607151712.GA7510@sirena.org.uk>
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

T24gVHVlLCAwNyBKdW4gMjAxNiwgTWFyayBCcm93biB3cm90ZToKPiBPbiBUdWUsIEp1biAwNywg
MjAxNiBhdCAxMjoxOTozMFBNICswMTAwLCBMZWUgSm9uZXMgd3JvdGU6Cj4gPiBEdWUgdG8gdGhl
IG5ld2x5IHVwc3RyZWFtZWQgJ2NyaXRpY2FsIGNsb2NrcycgQVBJIHdlIGNhbiBub3cKPiA+IHNh
ZmVseSBoYW5kbGUgY2xvY2tpbmcgaW4gdGhlIFNQSSBhbmQgSTJDIGRyaXZlcnMgd2l0aG91dCBm
ZWFyCj4gPiBvZiBjYXRhc3Ryb3BoaWNhbGx5IGNyaXBwbGluZyB0aGUgcnVubmluZyBwbGF0Zm9y
bS4KPiAKPiBBY2tlZC1ieTogTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPgoKV2UgcmVh
bGx5IG5lZWQgdG8gZ3VhcmFudGVlIHRoYXQgdGhpcyBnb2VzIGluICphZnRlciogdGhlIG90aGVy
CnBhdGNoZXMgaGF2ZSBsYW5kZWQsIGFuZCBpdCBsb29rcyBsaWtlIHRoZXkncmUgaGVhZGluZyBp
biB2aWEgdGhlaXIKb3duIHJlc3BlY3RpdmUgdHJlZXMuICBBbnkgY2hhbmNlIHlvdSBjYW4gaG9s
ZCB0aGlzIGJhY2sgYW5kIHN1Ym1pdCBpdAp2aWEgeW91ciB2NC44LWZpeGVzIHN1Ym1pc3Npb24/
CgotLSAKTGVlIEpvbmVzCkxpbmFybyBTVE1pY3JvZWxlY3Ryb25pY3MgTGFuZGluZyBUZWFtIExl
YWQKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxv
dyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
