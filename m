From: naga suresh kumar <nagasureshkumarrelli@gmail.com>
Subject: Re: [RFC PATCH 0/5] RFC for Zynq QSPI
Date: Wed, 26 Jun 2019 15:23:36 +0530
Message-ID: <CALgLF9JrTODVPJV8K-TkeN4cAOr88YJT2Swt-jCz_4KN-nwa3A@mail.gmail.com>
References: <1521807722-21626-1-git-send-email-nagasure@xilinx.com>
 <BY2PR02MB14115B9E46B35A59AC6505D9AFB00@BY2PR02MB1411.namprd02.prod.outlook.com>
 <CALgLF9K=rZxVx_QXvV_LH3OhidTcguZ=K=p=Lf9AfFbk4H+8Zw@mail.gmail.com>
 <20180917170522.0312ae8c@bbrezillon>
 <CALgLF9JVweEcEm6L33HaHp4HtXhmsZL7J5FDe8+O11i0Q1nukg@mail.gmail.com>
 <20180918091712.2f97db80@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: vigneshr@ti.com, linux-spi@vger.kernel.org,
 =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marek.vasut@gmail.com>,
 Mark Brown <broonie@kernel.org>, Naga Sureshkumar Relli <nagasure@xilinx.com>,
 linux-mtd@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Boris Brezillon <boris.brezillon@collabora.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180918091712.2f97db80@bbrezillon>
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

Hi Boris,

On Tue, Sep 18, 2018 at 12:47 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> Hi Naga,
>
> On Tue, 18 Sep 2018 11:26:05 +0530
> naga suresh kumar <nagasureshkumarrelli@gmail.com> wrote:
>
> > Hi,
> >
> > Please see my reply inline by prefacing my name, currently i am facing
> > issues with my outlook. the reply looks not good but please don't mind.
>
> I do mind. Please find a way to fix that, 'cause I'm pretty sure others
> will soon complain about that too.
>
>
> > > > As i said, it needs tweaking the mtd->size and spi read/write addresses.
> > >
> > > Can you elaborate a bit on why you think this is needed? Did you look
> > > at [1]? Maybe it will prevent us from exposing the flash size at the
> > > spi-mem level.
> > > [naga]: some example snippet below
> > >
> > > spi_nor_read () {
> > >
> > >    if (nor->isparallel == 1)
> > >
> > >    {
> > >
> > >       offset /= 2; //byte stripping will happen here
> > >
> > >        nor->spi->master->flags |= SPI_DATA_STRIPE;
> > >
> > >        //By setting this flag even bits of data word located in lower
> > > memory and odd are in upper memory
> > >
> > >    }
> > >
> > >    if (nor->isstacked == 1) {
> > >
> > >      stack_shift = 1;
> > >
> > >      if (offset >= (mtd->size / 2)) {
> > >
> > >      offset = offset - (mtd->size / 2);
> > >
> > >      nor->spi->master->flags |= SPI_MASTER_U_PAGE;
> > >
> > >      //We can access Upper memory or lower memory, by setting this flag in
> > > controller.
> > >
> > >   } else {
> > >
> > >         nor->spi->master->flags &= ~SPI_MASTER_U_PAGE;
> > >
> > >   }
> > >
> > >  }
> > >
> > > same for spi_nor_write() also.
>
> Let's put the stacked and parallel support on the side for now and
> focus on single die/chip support. Will find a clean way to handle that
> afterwards.
>
> > >
> > > Also in both dual parallel and stacked mode mtd->size should be sum of
> > > both flash device sizes
>
> Yes, but this information should stay at the spi-nor/mtd level.
>
> > >
> > > also status register read will change, it needs status from both devices.
> > > like that some changes
> > >
> > > will be needed in core.
>
> Which is why this needs to be handled in spi-nor.c. The spi-nor core
> needs to know about the parallel/stack setup and handle it differently
> (read both status bytes, read both IDs, ...).
>
> > > > Can somebody share your thoughts on this(Adding Zynq QSPI Dual parallel
> > > and
> > > > stacked)?
> > >
> > > I always have a hard time with this naming. I guess stacked is when you
> > > have 2 chips sharing the same I/O bus, and parallel is when you have 2
> > > chips with one taking all of the I/O and the other taking the other
> > > half. Is that correct?
> > > [naga]: Yes, you are correct, i have attached the diagrams for these mode.
> > >
> > > In parallel mode, with the help of controller STRIPE feature, even bits of
> > >
> > > data words are located in lower memory and odd bits are located in upper
> > > memory.
> > >
> > > Data management will be taken care by controller in both modes
>
> Ok. I need to think about it a bit more. In the meantime, I recommend
> that you submit a version of the driver that does not support parallel
> and stacked modes.

As you suggested previously, i have added the support for Zynq QSPI
controller to support single chip.
Currently i am planning to add support for Parallel and Stacked for the same.
Could you please provide your implementation thoughts on this Parallel
and Stacked mode?

>From my side, i am thinking like below.
Will take two config entries CONFIG_SPI_XLNX_PARALLEL and
CONFIG_SPI_XLNX_STACKED
and
#ifdef CONFIG_SPI_XILINX_PARALLEL
   #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors, _flags) \
   ------
  .sector_size = (_sector_size) << 1, \
  .n_sectors = (_n_sectors), \
  .page_size = (256 << 1), \
  .flags = (_flags | SPI_NOR_XLNX_PARALLEL),
#elif CONFIG_SPI_XILINX_STACKED
    #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors, _flags) \
    -------
  .sector_size = (_sector_size), \
  .n_sectors = (_n_sectors << 1), \
  .page_size = 256, \
  .flags = (_flags | SPI_NOR_XLNX_STACKED),
#else
  #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors, _flags) \
   ------
 .sector_size = (_sector_size), \
  .n_sectors = (_n_sectors), \
  .page_size = 256, \
 .flags = (_flags),
 #endif
>

And in the spi_nor_scan()
if (info->flags & (SPI_NOR_XLNX_PARALLEL || SPI_NOR_XLNX_STACKED)) {
        mtd->size = (params.size << 1);
        if (info->flags & SPI_NOR_XLNX_PARALLEL) {
            nor->spi->controller->flags |= (SPI_CONTROLLER_BOTH_CS |
SPI_CONTROLLER_DATA_STRIPE);
            nor->flags |= SNOR_F_XLNX_PARALLEL;
        } else if (info->flags & SPI_NOR_XLNX_STACKED) {
            nor->flags |= SNOR_F_XLNX_STACKED;
       }
}
Based on these flags, will alter the address to write/read, in
spi_nor_write() and spi_nor_read().
i will send an RFC patch with this update just to give show case this feature.

So could you please provide a way to implement the same?
i have also seen, that NXP flex controller is also supporting Parallel
flash mode, but not sure how
they are handling the chip select and mtd->size, page_size etc...
Sorry to bother you, but your suggestions helps a lot.

Thanks,
Naga Sureshkumar Relli

> Regards,
>
> Boris

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
