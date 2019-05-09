From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF MFD bindings
Date: Thu, 9 May 2019 22:23:04 +0300
Message-ID: <a05cff8f-7df2-1938-c0e7-f9366bece607@cogentembedded.com>
References: <1556092536-17095-1-git-send-email-masonccyang@mxic.com.tw>
 <1556092536-17095-4-git-send-email-masonccyang@mxic.com.tw>
 <20190424212356.GA27103@bogus>
 <65853dc2-6f3c-1494-7e72-54877797cdd2@gmail.com>
 <20190507125730.GD29524@dell>
 <OF08A5650B.8AE8977C-ON482583F4.000E5B1E-482583F4.000F7215@mxic.com.tw>
 <d229b19e-351c-c576-b5c4-716d10dad1a0@gmail.com> <20190508061119.GB7627@dell>
 <OFE86674B9.06D723A0-ON482583F5.000AD50C-482583F5.000BA075@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, mark.rutland@arm.com,
        Rob Herring <robh@kernel.org>, zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw, Lee Jones <lee.jones@linaro.org>,
        Marek Vasut <marek.vasut@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OFE86674B9.06D723A0-ON482583F5.000AD50C-482583F5.000BA075@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello!

On 05/09/2019 05:06 AM, masonccyang@mxic.com.tw wrote:

[...]
>> > >> > On 4/24/19 11:23 PM, Rob Herring wrote:
>> > >> > > On Wed, Apr 24, 2019 at 03:55:36PM +0800, Mason Yang wrote:
>> > >> > >> Document the bindings used by the Renesas R-Car Gen3 RPC-IF MFD.
>> > >> > >>
>> > >> > >> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> > >> > >> ---
>> > >> > >>  .../devicetree/bindings/mfd/mfd-renesas-rpc.txt    | 40 ++++++
>> > >> ++++++++++++++++
>> > >> > >>  1 file changed, 40 insertions(+)
>> > >> > >>  create mode 100644 Documentation/devicetree/bindings/mfd/mfd-
>> > >> renesas-rpc.txt
>> > >> > >>
>> > >> > >> diff --git a/Documentation/devicetree/bindings/mfd/mfd-renesas-
>> > >> rpc.txt b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
>> > >> > >> new file mode 100644
>> > >> > >> index 0000000..668b822
>> > >> > >> --- /dev/null
>> > >> > >> +++ b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
>> > >> > >> @@ -0,0 +1,40 @@
>> > >> > >> +Renesas R-Car Gen3 RPC-IF MFD Device Tree Bindings
>> > >> > >> +--------------------------------------------------
>> > >> > >
>> > >> > > Looks like a SPI flash controller from the example. What makes it an
>> > >> > > MFD?
>> > >> >
>> > >> > It supports both SPI NOR and HyperFlash (CFI-compliant flash with
>> > >> > different bus interface).
>> > >>
>> > >> Looks like you're registering one OR the other.
>> > >>
>> > >> Why don't you just do this from DT?
>> > >>
>> > >> No reason for this to be an MFD IMHO.
>> > >
>> > >
>> > > okay, I will patch it back to SPI mode only.
>> >
>> > I don't think that's what Lee meant . The controller supports _both_
>> > modes , hence it would have the same compatible string. You just need to
>> > extract the mode of operation from the DT.
>>
>> HiSilicon attempted to upstream something similar, only their
>> controller provided NAND and NOR functionality.  They used different
>> compatible strings to differentiate between the varying
>> technologies.
>>
>> They too tried to use MFD as a means to select between them (which was
>> also NACKed).  Not sure what they ended up doing, but the original
>> submission and (half of) the conversation can be found at [0].  Some
>> more of the thread continues at [1].
>>
>> Hope that helps.
>>
>> [0] https://groups.google.com/forum/#!topic/fa.linux.kernel/F6i9o8sfOIw
>> [1] https://marc.info/?l=devicetree&m=147669165104431&w=2
> 
> 
> Hi Marek,
> 
> By Jones's comments:
> --------------------------------------------------------------------------
>> From: Shunquan Lin <linshunquan1@hisilicon.com>
>>
>> This patch adds driver support for HiSilicon Flash Memory
>> Controller(FMC). HiSilicon FMC is a multi-functions device which
>> supports SPI Nor flash controller, SPI nand Flash controller and
>> parallel nand flash controller.
> 
> MFDs are for devices which span multiple subsystems.

   And we do! One of the subdrivers will live under drivers/spi/, the other
under drivers/mtd/...

> 
> Please submit this to MTD.
> 
> _https://marc.info/?l=devicetree&m=147376842210229&w=2_
> -------------------------------------------------------------------------------------------------
> 
> 
> I will patch RPC-IF back to SPI mode according to previous patches:

   I still don't see why you want to do this...

> -----------------------------------------------------------------------
> On 2/12/19 3:22 PM, Mark Brown wrote:
>> The patch
>>
>>    spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
>>
>> has been applied to the spi tree at
>>
>>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
>>
>> All being well this means that it will be integrated into the linux-next
>> tree (usually sometime in the next 24 hours) and sent to Linus during
>> the next merge window (or sooner if it is a bug fix), however if
>> problems are discovered then the patch may be dropped or reverted.  
>>
>> You may get further e-mails resulting from automated or manual testing
>> and review of the tree, please engage with people reporting problems and
>> send followup patches addressing any issues that are reported if needed.
>>
>> If any updates are required or you are submitting further changes they
>> should be sent as incremental updates against current git, existing
>> patches will not be replaced.
>>
>> Please add any relevant lists and maintainers to the CCs when replying
>> to this mail.
> ------------------------------------------------------------------------
> 
> agreed it ?

   No, I don't agree.

[...]
> thanks & best regards,
> Mason

MBR, Sergei
