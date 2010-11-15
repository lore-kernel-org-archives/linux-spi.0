From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC 11/18] spi: add SPI controller driver for the Atheros
 AR71XX/AR724X/AR913X SoCs
Date: Mon, 15 Nov 2010 09:28:05 -0700
Message-ID: <AANLkTiknq2Rdzp-xb-xTm5c_1QwBsq_vsS1N3iAL_Xn7@mail.gmail.com>
References: <1289598684-30624-1-git-send-email-juhosg@openwrt.org>
 <1289598684-30624-12-git-send-email-juhosg@openwrt.org> <20101114082242.GA3137@angua.secretlab.ca>
 <4CE04EBC.4080701@openwrt.org> <20101115040456.GB19965@angua.secretlab.ca> <4CE0F8D1.8000704@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-mips@linux-mips.org, "Luis R. Rodriguez" <mcgrof@gmail.com>,
        Cliff Holden <Cliff.Holden@atheros.com>,
        David Brownell <dbrownell@users.sourceforge.net>,
        spi-devel-general@lists.sourceforge.net,
        Imre Kaloz <kaloz@openwrt.org>
To: Gabor Juhos <juhosg@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <4CE0F8D1.8000704@openwrt.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Id: linux-spi.vger.kernel.org

On Mon, Nov 15, 2010 at 2:09 AM, Gabor Juhos <juhosg@openwrt.org> wrote=
:
> 2010.11.15. 5:04 keltez=E9ssel, Grant Likely =EDrta:
>> On Sun, Nov 14, 2010 at 10:03:56PM +0100, Gabor Juhos wrote:
>>>>> +static inline u32 ath79_spi_rr(struct ath79_spi *sp, unsigned re=
g)
>>>>> +{
>>>>> + =A0return __raw_readl(sp->base + reg);
>>>>> +}
>>>>> +
>>>>> +static inline void ath79_spi_wr(struct ath79_spi *sp, unsigned r=
eg, u32 val)
>>>>> +{
>>>>> + =A0__raw_writel(val, sp->base + reg);
>>>>> +}
>>>>
>>>> This is suspect. =A0Why is __raw_{readl,writel} being used instead=
 of
>>>> ioread32/iowrite32? =A0The __raw versions don't provide any kind o=
f
>>>> ordering barriers.
>>>
>>> Mainly because the resulting code is smaller, and the performance i=
s a bit
>>> better with the use of the __raw versions. The controller is embedd=
ed into the
>>> SoC and the registers are memory mapped, so i think it is safe to a=
ccess them
>>> with __raw_{readl,writel}. However I can change it if that is the p=
referred method.
>>>
>>
>> Smaller, yes, because it doesn't have any io barriers; but is it saf=
e?
>> Do you know whether or not the CPU will reorder the instructions on
>> you? =A0Being embedded into the SoC doesn't really mean anything in =
this
>> regard. =A0Unless you really understand all the behaviour of the CPU=
 and
>> bus, then the safe versions must be used.
>>
>> If you *do* really understand all the behaviour and decide it is saf=
e
>> to use the __raw versions, then the driver needs to be well document=
ed
>> as to the reasons why the __raw versions are safe to use.
>
> These SoCs are using the MIPS 24K core. This core is based on an in-o=
rder
> architecture, so it is safe to use the __raw versions from the CPU's =
side.
>
> To be honest, I have no informations about that the completion of the=
 request is
> always in order that the request are received on the AHB bus between =
the CPU and
> the SPI controller. However the Atheros' reference code uses the __ra=
w versions
> everywhere to access the registers of the built-in devices, so I assu=
me that no
> out-of-order completion is allowed on that bus.

Ralf, what say you?  I personally don't like this, and it makes for a
bad example of driver code, but I'll accept it if you say that it is
the right thing to do for MIPS device drivers.  (Although I retain my
requirement that the use of __raw accessors needs to be well
documented).

g.
