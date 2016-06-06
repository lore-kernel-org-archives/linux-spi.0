From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 2/2] mtd: m25p80: consider max_transfer_size when reading
Date: Mon, 6 Jun 2016 23:20:53 +0200
Message-ID: <971ad721-5644-e5f9-2918-65db0e6b1996@gmail.com>
References: <56D22823.7090005@gmail.com> <20160405193952.GA5243@localhost>
 <57041B43.2000109@gmail.com> <20160405210727.GB5243@localhost>
 <5706B084.2070909@gmail.com> <20160505235700.GA99474@google.com>
 <20160506121431.GQ6292@sirena.org.uk>
 <77a22258-95ca-031a-825d-a9e98e30a162@gmail.com>
 <20160606174003.GE7510@sirena.org.uk>
 <a57adb90-0d80-186f-17d3-6fdf106bfb4a@gmail.com>
 <CAMuHMdW5zEmiN=Qw+Ed-gi=M1FffHXu1uSEvUOuRDG+j14ZZBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marex@denx.de>, Michal Suchanek <hramrach@gmail.com>,
 linux-spi <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 MTD Maling List <linux-mtd@lists.infradead.org>, Han Xu <han.xu@nxp.com>,
 Cyrille Pitchen <cyrille.pitchen@atmel.com>,
 Brian Norris <computersforpeace@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <CAMuHMdW5zEmiN=Qw+Ed-gi=M1FffHXu1uSEvUOuRDG+j14ZZBA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Am 06.06.2016 um 21:46 schrieb Geert Uytterhoeven:
> Hi Heiner,
> 
> On Mon, Jun 6, 2016 at 8:53 PM, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>> Am 06.06.2016 um 19:40 schrieb Mark Brown:
>>> On Sat, Jun 04, 2016 at 12:22:37AM +0200, Heiner Kallweit wrote:
>>>> Am 06.05.2016 um 14:14 schrieb Mark Brown:
>>>>> Yes, it's called the maximum transfer size because it is the
>>>>> maximum size of a transfer, not because it's the maximum size of
>>>>> a message.
>>>
>>>> I'd like to come back to this discussion. You said best would be
>>>> to fix the chip driver. To do this and calculate an appropriate
>>>> value for max_transfer_size the chip driver would have to know that
>>>> the spi_device is a spi-nor device.
>>>
>>> That doesn't make any sense, the controller hardware doesn't
>>> magically change based on what is connected to it.
>>>
>> The issue with fsl-espi is that the controller deactivates CS after
>> each physical transfer. And a lot of HW designs use the hardware CS,
>> therefore the advise to use a GPIO instead doesn't really help.
> 
> And you can't use pinmux to configure the pin used for hardware CS
> to become a GPIO?
> 
Sadly enough, no. Only the complete block of SPI signals can be switched
to GPIO mode. But then we'd have to use bitbanging and would loose all
features of the integrated SPI controller (FIFO's etc.)

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
