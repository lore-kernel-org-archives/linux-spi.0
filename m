From: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>
Subject: Re: [PATCH v3] xilinx_spi: Splitted into generic, of and platform
	driver, added support for DS570
Date: Thu, 24 Sep 2009 09:36:29 +0200
Message-ID: <4ABB217D.9070708@mocean-labs.com>
References: <4AB8C936.5090409@mocean-labs.com>
	<20090922155952.8171518B8046@mail30-sin.bigfish.com>
	<4AB948AB.8080002@mocean-labs.com>
	<20090923224452.EAAFEB48046@mail109-sin.bigfish.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>,
	dbrownell@users.sourceforge.net, linuxppc-dev@ozlabs.org
To: John Linn <John.Linn@xilinx.com>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20090923224452.EAAFEB48046@mail109-sin.bigfish.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

Hi again,

John Linn wrote:
>> -----Original Message-----
>> From: Richard R=F6jfors [mailto:richard.rojfors@mocean-labs.com]
>> Sent: Tuesday, September 22, 2009 3:59 PM
>> To: John Linn
>> Cc: spi-devel-general@lists.sourceforge.net; linuxppc-dev@ozlabs.org; An=
drew Morton;
>> dbrownell@users.sourceforge.net
>> Subject: Re: [PATCH v3] xilinx_spi: Splitted into generic, of and platfo=
rm driver, added support for
>> DS570
>>
>> John Linn wrote:
>>>> -----Original Message-----
>>>> From: linuxppc-dev-bounces+john.linn=3Dxilinx.com@lists.ozlabs.org [ma=
ilto:linuxppc-dev-
>>>> bounces+john.linn=3Dxilinx.com@lists.ozlabs.org] On Behalf Of Richard =
R=F6jfors
>>>> Sent: Tuesday, September 22, 2009 6:55 AM
>>>> To: spi-devel-general@lists.sourceforge.net
>>>> Cc: linuxppc-dev@ozlabs.org; Andrew Morton; dbrownell@users.sourceforg=
e.net
>>>> Subject: [PATCH v3] xilinx_spi: Splitted into generic, of and platform=
 driver, added support for
>>>> DS570
>>>>
>>>> This patch splits xilinx_spi into three parts, an OF and a platform
>>>> driver and generic part.
>>>>
>>>> The generic part now also works on X86 and also supports the Xilinx
>>>> SPI IP DS570
>>> Hi Richard,
>> Hi John,
>>
>>> The current driver (without this change) works for the newer XPS SPI de=
vice already as I run tests
>> on it each day using an SPI EEPROM.
>>
>> I'm not an expert of the Xilinx SPI blocks, I have only used one, the DS=
570.
>>
>> I don't think you use the DS570. I don't have the datasheet of the older=
 one, but the register
>> offsets of the DS570 don't match the driver you are using. All the regis=
ters of the DS570 are at 4
>> bytes boundries.
>>
> =

> I just verified that I am using the same IP block as you are, the DS570. =
But I'm not testing on the other IP you mention, the DS464.

Hi,

I have now verified the differences. Actually the blocks are register offse=
t compatible. Since the
DS464 is 8 bit only, the driver is made to do only 8 bit accesses to some r=
egisters, for instance
TXD. On the 570 we have to do 32 bit (or at least 16) as the driver now sup=
port more than 8bit SPI.
We test against some SPI devices that are 16 bit.
The offsets in the code differs from the datasheet because since the device=
 is big endian -> an 8
bit access to must happen 3 bytes up from the register base.

For instance the TXD register is defined at 0x6b, while the spec says 0x68.=
 0x68 + 0x3 =3D 0x6b. To
support more than 8 bit, we must do 16 bit access at 0x6a or 32 bit at 0x68.

To summarize;
You are completely right you can use the "old" driver on the DS570 as well,=
 but _only_ for 8bit SPI.
My patch allows to run on X86 and with 16 or 32bit SPI.

Thanks to the observation from you, I got aware of the differences. I can s=
implify the code by
automatically increase registers offsets when doing 8 or 16 bits accesses.
I will come back with an updated patch.

Hope I made the situation clearer.

--Richard
