From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Mon, 22 Apr 2019 19:44:04 +0300
Message-ID: <529fe004-63e2-43c3-0382-9aaa86d0c3a9@cogentembedded.com>
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
 <1e2bf23d-db39-0d1d-0bcc-6d9cd2935a82@cogentembedded.com>
 <cdee3d53-6ee3-4435-117e-8ba4a58ca72b@cogentembedded.com>
 <OF82CE76E9.E6395EF7-ON482583DD.000E37D7-482583DD.000E5077@mxic.com.tw>
 <3d334751-8fd4-7db1-9deb-e6c94936df13@cogentembedded.com>
 <OF4ABCC306.B053BA23-ON482583E0.000F480C-482583E0.000FAD4A@mxic.com.tw>
 <3971c669-9095-9d18-d029-37f9663a54b2@cogentembedded.com>
 <OF58AAFF49.C4593DEB-ON482583E1.001D551E-482583E1.001F089D@LocalDomain>
 <OFE74649D4.F69BB5EF-ON482583E1.0033F73F-482583E1.00344ED2@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org,
        zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OFE74649D4.F69BB5EF-ON482583E1.0033F73F-482583E1.00344ED2@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 04/19/2019 12:31 PM, masonccyang@mxic.com.tw wrote:

>> > Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
>> >
>> > On 04/18/2019 05:51 AM, masonccyang@mxic.com.tw wrote:
>> >
>> > >> >> >> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
>> > >> >> >>
>> > >> >> >> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> > >> >> >> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> > >> >> > [...]
>> > >> >> >> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-
>> > >> renesas-rpc.c
>> > >> >> >> new file mode 100644
>> > >> >> >> index 0000000..037f273
>> > >> >> >> --- /dev/null
>> > >> >> >> +++ b/drivers/spi/spi-renesas-rpc.c
>> > >> >> > [...]
>> > >> >> >> +static int rpc_spi_probe(struct platform_device *pdev)
>> > >> >> >> +{
>> > >> >> >> +   struct spi_controller *ctlr;
>> > >> >> >> +   struct rpc_mfd *rpc_mfd = dev_get_drvdata(pdev->dev.parent);
>> > >> >> >> +   struct rpc_spi *rpc;
>> > >> >> >> +   int ret;
>> > >> >> >> +
>> > >> >> >> +   ctlr = spi_alloc_master(&pdev->dev, sizeof(*rpc));
>> > >> >> >> +   if (!ctlr)
>> > >> >> >> +      return -ENOMEM;
>> > >> >> >> +
>> > >> >> >> +   platform_set_drvdata(pdev, ctlr);
>> > >> >> >> +
>> > >> >> >> +   rpc = spi_controller_get_devdata(ctlr);
>> > >> >> >> +
>> > >> >> >> +   ctlr->dev.of_node = pdev->dev.of_node;
>> > >> >> > [...]
>> > >> >> >> +
>> > >> >> >> +   pm_runtime_enable(&pdev->dev);
>> > >> >> >> +   ctlr->auto_runtime_pm = true;
>> > >> >> >
>> > >> >> >    I think this line no longer works as expected with the new
>> > >> >> probing scheme.
>> > >>
>> > >>    That's because we added another (SPI) device under our MFD.
>> > >
>> > > Do you mean just to remove one line
>> > > ctlr->auto_runtime_pm = true;
>> > > ?
> 
>> how did you test it ?
>> what is your testing flow ?

   I think I've patched drivers/spi/spi-mem.c to get spi_mem_access_{start|end}()
to be called with ctlr->dev.parent->parent as an arg...

>> >    No, you should explicitly call RPM for the MFD (not the SPI device).
>>
>> okay, patch RPM to RPC MFD and will remove SPI RPM enable part.
> 
> wait! I test it ok.
> 
> Don't need to patch RPM to RPC MFD, just keep RPM in SPI.
> 
> root@draak:/sys/power# echo mem > state
> [  135.848711] PM: suspend entry (s2idle)
> [  135.852777] PM: Syncing filesystems ... done.
> [  135.869468] Freezing user space processes ... (elapsed 0.002 seconds) done.
> [  135.879962] OOM killer disabled.
> [  135.883257] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
> [  135.893474] Suspending console(s) (use no_console_suspend to debug)
> [  135.910946] [Mason] rpc_spi_suspend
> [  135.986022] PM: suspend devices took 0.084 seconds
> [  135.986047] PM: suspend debug: Waiting for 5 second(s).
> [  141.142024] [Mason] rpc_spi_resume
> [  141.220859] PM: resume devices took 0.116 seconds
> [  141.243179] OOM killer enabled.
> [  141.246417] Restarting tasks ... done.
> [  141.266579] PM: suspend exit
> root@draak:/sys/power#

   That's not *runtime* PM, it's the *plain* PM you're testing here...

> thanks & best regards,
> Mason

MBR, Sergei
