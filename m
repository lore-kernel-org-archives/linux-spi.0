From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
Date: Thu, 6 Dec 2018 09:56:43 +0100
Message-ID: <2c6c23fc-299a-f64d-c81f-4b4123f1577b@gmail.com>
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-2-git-send-email-masonccyang@mxic.com.tw>
 <CAMuHMdWEiOTSSM=rKu67r-kgJ=TyAi7p7ndhAS4d5-6gccmmoQ@mail.gmail.com>
 <OFE69673FB.D4270C56-ON4825835B.001C7201-4825835B.00209DC7@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>, zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw, Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OFE69673FB.D4270C56-ON4825835B.001C7201-4825835B.00209DC7@mxic.com.tw>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 12/06/2018 06:56 AM, masonccyang@mxic.com.tw wrote:
> Hi Geert,
> 
>> "Geert Uytterhoeven" <geert@linux-m68k.org>
>> 2018/12/05 下午 05:06
>>
>> To
>>
>> masonccyang@mxic.com.tw,
>>
>> cc
>>
>> "Mark Brown" <broonie@kernel.org>, "Marek Vasut"
>> <marek.vasut@gmail.com>, "Linux Kernel Mailing List" <linux-
>> kernel@vger.kernel.org>, "linux-spi" <linux-spi@vger.kernel.org>,
>> "Boris Brezillon" <boris.brezillon@bootlin.com>, "Linux-Renesas"
>> <linux-renesas-soc@vger.kernel.org>, "Geert Uytterhoeven" <geert
>> +renesas@glider.be>, juliensu@mxic.com.tw, "Simon Horman"
>> <horms@verge.net.au>, zhengxunli@mxic.com.tw
>>
>> Subject
>>
>> Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller driver
>>
>> Hi Mason,
>>
>> On Mon, Dec 3, 2018 at 10:19 AM Mason Yang <masonccyang@mxic.com.tw>
> wrote:
>> > Add a driver for Renesas R-Car Gen3 RPC SPI controller.
>> >
>> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>>
>> Thanks for your patch!
>>
>> > --- a/drivers/spi/Kconfig
>> > +++ b/drivers/spi/Kconfig
>> > @@ -528,6 +528,12 @@ config SPI_RSPI
>> >         help
>> >           SPI driver for Renesas RSPI and QSPI blocks.
>> >
>> > +config SPI_RENESAS_RPC
>> > +       tristate "Renesas R-Car Gen3 RPC SPI controller"
>> > +       depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
>>
>> So this driver is intended for SuperH SoCs, too?
>> If not, please drop the dependency.
>>
> 
> okay, I will drop "SUPERH".
> 
>> > --- /dev/null
>> > +++ b/drivers/spi/spi-renesas-rpc.c
>>
>> > +#ifdef CONFIG_RESET_CONTROLLER
>> > +static int rpc_spi_do_reset(struct rpc_spi *rpc)
>>
>> What's the purpose of the reset routine?
> 
> in case RPC xfer is time-out due to something wrong in RPC module,
> as Marek comments.
> 
>> Given the #ifdef, is it optional or required?
>>
>> > +{
>> > +       int i, ret;
>> > +
>> > +       ret = reset_control_reset(rpc->rstc);
>> > +       if (ret)
>> > +               return ret;
>> > +
>> > +       for (i = 0; i < LOOP_TIMEOUT; i++) {
>> > +               ret = reset_control_status(rpc->rstc);
>> > +               if (ret == 0)
>> > +                       return 0;
>> > +               usleep_range(0, 1);
>> > +       }
>>
>> Why do you need this loop?
>> The delay in cpg_mssr_reset() should be sufficient.
>>
> 
> yup, I know there is already 35 us delay in cpg_mssr_reset().
> If you think reset_control_status()checking is not necessary,
> I will drop it.
> 
>> > +
>> > +       return -ETIMEDOUT;
>> > +}
>> > +#else
>> > +static int rpc_spi_do_reset(struct rpc_spi *rpc)
>> > +{
>> > +       return -ETIMEDOUT;
>> > +}
>> > +#endif
>>
>> > +static int rpc_spi_transfer_one_message(struct spi_master *master,
>> > +                                       struct spi_message *msg)
>> > +{
>> > +       struct rpc_spi *rpc = spi_master_get_devdata(master);
>> > +       struct spi_transfer *t;
>> > +       int ret;
>> > +
>> > +       rpc_spi_transfer_setup(rpc, msg);
>> > +
>> > +       list_for_each_entry(t, &msg->transfers, transfer_list) {
>> > +               if (!list_is_last(&t->transfer_list, &msg->transfers))
>> > +                       continue;
>> > +               ret = rpc_spi_xfer_message(rpc, t);
>>
>> rpc_spi_xfer_message() sounds like a bad name to me, given it operates
>> on a transfer, not on a message.
>>
> 
> Because RPC send a entire SPI message at one time, not separately,
> that is the 1'st transfer is for command, the 2'nd transfer is for
> address/data
> and so on.
> The reason is CS# pin control restriction in RPC HW module.
> 
> 
>> > +               if (ret)
>> > +                       goto out;
>> > +       }
>> > +
>> > +       msg->status = 0;
>> > +       msg->actual_length = rpc->totalxferlen;
>> > +out:
>> > +       spi_finalize_current_message(master);
>> > +       return 0;
>> > +}
>>
>>
>> > +static int rpc_spi_probe(struct platform_device *pdev)
>> > +{
>>
>> > +       rpc->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
>> > +       if (IS_ERR(rpc->rstc))
>> > +               return PTR_ERR(rpc->rstc);
>>
>> This will return an error if CONFIG_RESET_CONTROLLER is not set, hence
>> the #ifdef above is moot.
>>
> 
> You are right.
> so, I should do
> Option 1: remove #CONFIG_RESET_CONTROLLER
> Option 2: add #CONFIG_RESET_CONTROLLER for
> devm_reset_control_get_exclusive()
> 
> please comments on it, thanks.
> 
> 
>> > +
>> > +       pm_runtime_enable(&pdev->dev);
>> > +       master->auto_runtime_pm = true;
>> > +
>> > +       master->num_chipselect = 1;
>> > +       master->mem_ops = &rpc_spi_mem_ops;
>> > +       master->transfer_one_message = rpc_spi_transfer_one_message;
>>
>> Is there any reason you cannot use the standard
>> spi_transfer_one_message, i.e. provide spi_controller.transfer_one()
>> instead of spi_controller.transfer_one_message()?
>>
> 
> It seems there is a RPC HW restriction in CS# pin control.
> Therefore, it can't send the 1'st spi-transfer for command and then
> keeping CS# pin goes low for the 2'nd spi-transfer for address/data and
> so on.

Isn't register DRCR bit SSLN/SSLE exactly for this purpose ?

-- 
Best regards,
Marek Vasut
