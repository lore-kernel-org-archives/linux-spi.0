From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] arm: mvebu: Add SPI flash on Armada XP-GP board
Date: Wed, 06 Feb 2013 13:31:23 +0100
Message-ID: <51124D1B.9030508@free-electrons.com>
References: <1360063473-26176-1-git-send-email-ezequiel.garcia@free-electrons.com>
	<5111331F.7090900@free-electrons.com>
	<511168BE.1000803@free-electrons.com>
	<20130206105431.GA21764@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130206105431.GA21764@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 02/06/2013 11:54 AM, Ezequiel Garcia wrote:
> Hi Gregory,
> 
> On Tue, Feb 05, 2013 at 09:17:02PM +0100, Gregory CLEMENT wrote:
>> On 02/05/2013 05:28 PM, Gregory CLEMENT wrote:
>>> Hi Ezequiel,
>>>
>>> On 02/05/2013 12:24 PM, Ezequiel Garcia wrote:
>>>> This patch adds an SPI master device node for Armada XP-GP board.
>>>> This master node is an SPI flash controller 'n25q128a13'.
>>>>
>>>> Since there is no 'partitions' node declared, one full sized
>>>> partition named as the device will be created.
>>>>
>>>> Cc: Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>>>> Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>>>> Cc: Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>>>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>>>> ---
>>>> This patch depends on:
>>>>
>>>>  1. Gregory's patch for Armada XP GP board:
>>>>       arm: mvebu: support for the new Armada XP development board(DB-MV784MP-GP)
>>>>
>>>>  2. My previous patch for SPI on Armada 370/XP:
>>>>       arm: mvebu: Add support for SPI controller in Armada 370/XP
>>>>
>>>> And don't forget to compile the SPI flash driver, CONFIG_MTD_M25P80=y
>>>>
>>>>  arch/arm/boot/dts/armada-xp-gp.dts |   12 ++++++++++++
>>>>  1 files changed, 12 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
>>>> index 3eea531..1c8afe2 100644
>>>> --- a/arch/arm/boot/dts/armada-xp-gp.dts
>>>> +++ b/arch/arm/boot/dts/armada-xp-gp.dts
>>>> @@ -97,5 +97,17 @@
>>>>  			phy = <&phy3>;
>>>>  			phy-mode = "rgmii-id";
>>>>  		};
>>>> +
>>>> +		spi0: spi@d0010600 {
>>>> +			status = "okay";
>>>> +
>>>> +			spi-flash@0 {
>>>> +				#address-cells = <1>;
>>>> +				#size-cells = <1>;
>>>> +				compatible = "n25q128a13";
>>>> +				reg = <0>; /* Chip select 0 */
>>>> +				spi-max-frequency = <108000000>;
>>
>> I had a remark about it, according to the datasheet, 108MHz is the
>> maximum frequency for the all the instructions but the READ
>> instruction. For the READ the maximum frequency is 54MHz. So I wonder
>> if we shouldn't use 54000000 here.
>>
> 
> Mmm... nice catch.
> 
> The mtd driver for the spi flash (m25p80) will use FAST_READ opcode
> if CONFIG_M25PXX_USE_FAST_READ is selected, and this option
> is selected by default.

OK I didn't notice that thre wre a FAST_READ which was supported by
Linux. So I think we can keep 108000000 as spi-max-frequency.

> However we cannot count on this option being selected, of course.
> 
> On the other side, after some testing with spi-max-frequency = 50 MHz
> and also with spi-max-frequency = 108 MHz I'm seeing the flash often
> (not always) stalls when trying to read the full device through dd:
> 
> / # dd if=/dev/mtd0ro of=/dev/null
> 
> This happens regardless of CONFIG_M25PXX_USE_FAST_READ, and regardless
> of spi-max-frequency = 50 MHz or 54 MHz or 108 MHz.
> 
> Note that setting 108 MHz is useless in our case, because there's
> an upper limit of 62.5 MHz set by the core clock of the SoC.
> 
> Using a read block size of 1M, the read completes OK -- always:
> 
> / # dd if=/dev/mtd0 of=/dev/null bs=1M
> 16+0 records in
> 16+0 records out
> 16777216 bytes (16.0MB) copied, 27.306048 seconds, 600.0KB/s
> 
> Moreover, when the read completes, the achieved bandwidth
> is the same for 40, 50, 54, or 108 MHz.
> 
> If we set spi-max-frequency to 27 MHz (108 MHz / 4), it looks like the stalling
> disappear and the read always completes OK, at almost half the speed:
> 
> / # dd if=/dev/mtd0ro of=/dev/null
> 32768+0 records in
> 32768+0 records out
> 16777216 bytes (16.0MB) copied, 49.005122 seconds, 334.3KB/s
> 
> So according to this analysis, we whould set 27 MHz as the max
> frequency, based on nothing but in these tests.
> 
> I'm not sure the stalling is due to the clocking or due to
> some driver bug (I don't like the tricks pulled by the busy loop
> in orion_spi_wait_till_ready() but probably this is completely unrelated).
> 
> Adding some SPI people in Cc, hoping they can shed a light on this.
> 
> What do you think?

We have just seen this on IRC, so it seemed it was actually a problem in
userspace not in kernel space.

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
