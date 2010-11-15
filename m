From: Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [RFC 11/18] spi: add SPI controller driver for the Atheros AR71XX/AR724X/AR913X
 SoCs
Date: Mon, 15 Nov 2010 10:09:37 +0100
Message-ID: <4CE0F8D1.8000704@openwrt.org>
References: <1289598684-30624-1-git-send-email-juhosg@openwrt.org> <1289598684-30624-12-git-send-email-juhosg@openwrt.org> <20101114082242.GA3137@angua.secretlab.ca> <4CE04EBC.4080701@openwrt.org> <20101115040456.GB19965@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "Luis R. Rodriguez" <mcgrof@gmail.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        David Brownell <dbrownell@users.sourceforge.net>,
        spi-devel-general@lists.sourceforge.net,
        Imre Kaloz <kaloz@openwrt.org>
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20101115040456.GB19965@angua.secretlab.ca>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Id: linux-spi.vger.kernel.org

2010.11.15. 5:04 keltez=E9ssel, Grant Likely =EDrta:
> On Sun, Nov 14, 2010 at 10:03:56PM +0100, Gabor Juhos wrote:
>>>> +static inline u32 ath79_spi_rr(struct ath79_spi *sp, unsigned reg=
)
>>>> +{
>>>> +	return __raw_readl(sp->base + reg);
>>>> +}
>>>> +
>>>> +static inline void ath79_spi_wr(struct ath79_spi *sp, unsigned re=
g, u32 val)
>>>> +{
>>>> +	__raw_writel(val, sp->base + reg);
>>>> +}
>>>
>>> This is suspect.  Why is __raw_{readl,writel} being used instead of
>>> ioread32/iowrite32?  The __raw versions don't provide any kind of
>>> ordering barriers.
>>
>> Mainly because the resulting code is smaller, and the performance is=
 a bit
>> better with the use of the __raw versions. The controller is embedde=
d into the
>> SoC and the registers are memory mapped, so i think it is safe to ac=
cess them
>> with __raw_{readl,writel}. However I can change it if that is the pr=
eferred method.
>>
>=20
> Smaller, yes, because it doesn't have any io barriers; but is it safe=
?
> Do you know whether or not the CPU will reorder the instructions on
> you?  Being embedded into the SoC doesn't really mean anything in thi=
s
> regard.  Unless you really understand all the behaviour of the CPU an=
d
> bus, then the safe versions must be used.
>=20
> If you *do* really understand all the behaviour and decide it is safe
> to use the __raw versions, then the driver needs to be well documente=
d
> as to the reasons why the __raw versions are safe to use.

These SoCs are using the MIPS 24K core. This core is based on an in-ord=
er
architecture, so it is safe to use the __raw versions from the CPU's si=
de.

To be honest, I have no informations about that the completion of the r=
equest is
always in order that the request are received on the AHB bus between th=
e CPU and
the SPI controller. However the Atheros' reference code uses the __raw =
versions
everywhere to access the registers of the built-in devices, so I assume=
 that no
out-of-order completion is allowed on that bus.

Regards,
Gabor
