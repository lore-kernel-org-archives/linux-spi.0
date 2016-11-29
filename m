From: Romain Perier <romain.perier@free-electrons.com>
Subject: Re: [PATCH 4/5] arm64: dts: marvell: Add definition of SPI controller
 for Armada 3700
Date: Tue, 29 Nov 2016 16:08:08 +0100
Message-ID: <0120e795-f1bb-6614-bdc7-22dbb9ab9f35@free-electrons.com>
References: <20161129143939.3191-1-romain.perier@free-electrons.com>
 <20161129143939.3191-5-romain.perier@free-electrons.com>
 <20161129155129.6f3c76b6@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, Pawel Moll <pawel.moll@arm.com>,
 devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Kumar Gala <galak@codeaurora.org>,
 Gregory Clement <gregory.clement@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161129155129.6f3c76b6@free-electrons.com>
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

Hello,

Le 29/11/2016 =E0 15:51, Thomas Petazzoni a =E9crit :

>
>> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/b=
oot/dts/marvell/armada-37xx.dtsi
>> index e9bd587..84e4f57 100644
>> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
>> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
>> @@ -98,6 +98,19 @@
>>  			/* 32M internal register @ 0xd000_0000 */
>>  			ranges =3D <0x0 0x0 0xd0000000 0x2000000>;
>>
>> +			spi0: spi@10600 {
>> +				compatible =3D "marvell,armada-3700-spi";
>> +				#address-cells =3D <1>;
>> +				#size-cells =3D <0>;
>> +				reg =3D <0x10600 0x5d>;
>> +				clocks =3D <&nb_periph_clk 7>;
>> +				clock-frequency =3D <200000000>;
>
> This property.
>
>> +				interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
>> +				max-frequency =3D <66000000>;
>
> And this one no longer exist in your DT binding, so I guess they should
> be removed from here as well.
>

Good point, I was pretty sure that I have removed these.
I probably did something wrong with my rebase.

Thanks,
Romain
