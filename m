From: Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH v5 0/6] bcm2835: auxiliar device support for spi
Date: Thu, 10 Sep 2015 18:02:47 +0100
Message-ID: <55F1B7B7.3050604@raspberrypi.org>
References: <1441359711-2800-1-git-send-email-kernel@martin.sperl.org>
 <87h9n4weg8.fsf@eliezer.anholt.net> <55F1A651.5090102@tronnes.org>
 <8B777380-A2A1-475E-8A1C-942BF28EE160@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-spi@vger.kernel.org, Eric Anholt <eric@anholt.net>,
 Mark Brown <broonie@kernel.org>, linux-rpi-kernel@lists.infradead.org,
 Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org
To: Martin Sperl <kernel@martin.sperl.org>, =?UTF-8?Q?Noralf_Tr=c3=b8nnes?=
 <noralf@tronnes.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <8B777380-A2A1-475E-8A1C-942BF28EE160@martin.sperl.org>
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

[ Sending again in plain text ]
Noralf pointed me at fixed-factor-clock, and that works in our
(downstream) environment:

    soc: soc {
        ...
        uart1: uart@7e215040 {
            compatible =3D "brcm,bcm2835-aux-uart", "ns16550";
            reg =3D <0x7e215040 0x40>;
            interrupts =3D <1 29>;
            clocks =3D <&clk_uart1>;
            reg-shift =3D <2>;
            no-loopback-test;
            status =3D "disabled";
            };
    };

    clocks: clocks {
        ...
        clk_core: clock@2 {
            compatible =3D "fixed-clock";
            reg =3D <2>;
            #clock-cells =3D <0>;
            clock-output-names =3D "core";
            clock-frequency =3D <250000000>;
        };
        ...
        clk_uart1: clock@6 {
            compatible =3D "fixed-factor-clock";
            clocks =3D <&clk_core>;
            #clock-cells =3D <0>;
            clock-div =3D <1>;
            clock-mult =3D <2>;
        };
    };

Phil

On 10/09/2015 16:57, Martin Sperl wrote:
>> On 10.09.2015, at 17:48, Noralf Tr=F8nnes <noralf@tronnes.org> wrote:
>>
>> This looks interesting.
>> But there's a challenge with the uart1 and the 8250 driver.
>>
>> Phil Elwell has this to say:
>> This means that that UART1 isn't an exact clone of a 8250 UART.
>> In a particular, the clock divisor is calculated differently.
>> A standard 8250 derives the baud rate as clock/(divisor16),
>> whereas the BCM2835 mini UART uses clock/(divisor8). This means
>> that if you want to use the standard driver then you need to lie
>> about the clock frequency, providing a value is twice the real
>> value, in order for a suitable divisor to be calculated.
>>
>> Ref: https://github.com/raspberrypi/linux/pull/1008#issuecomment-1392346=
07
>>
>> So either we need a new uart1 driver or a doubled clock freq. somehow.
> Found out the same thing and communicated it to Eric - not =

> knowing about the different divider=85
>
> Martin



On 10/09/2015 16:57, Martin Sperl wrote:
>> On 10.09.2015, at 17:48, Noralf Tr=F8nnes <noralf@tronnes.org> wrote:
>>
>> This looks interesting.
>> But there's a challenge with the uart1 and the 8250 driver.
>>
>> Phil Elwell has this to say:
>> This means that that UART1 isn't an exact clone of a 8250 UART.
>> In a particular, the clock divisor is calculated differently.
>> A standard 8250 derives the baud rate as clock/(divisor16),
>> whereas the BCM2835 mini UART uses clock/(divisor8). This means
>> that if you want to use the standard driver then you need to lie
>> about the clock frequency, providing a value is twice the real
>> value, in order for a suitable divisor to be calculated.
>>
>> Ref: https://github.com/raspberrypi/linux/pull/1008#issuecomment-1392346=
07
>>
>> So either we need a new uart1 driver or a doubled clock freq. somehow.
> Found out the same thing and communicated it to Eric - not =

> knowing about the different divider=85
>
> Martin
