From: "B48286@freescale.com" <B48286@freescale.com>
Subject: RE: [PATCH v2] mtd: m25p80: Make the name of mtd_info fixed
Date: Thu, 13 Feb 2014 08:08:33 +0000
Message-ID: <f5fa7d36121e4939b99115dc4a3154f5@DM2PR03MB301.namprd03.prod.outlook.com>
References: <1390717003-28699-1-git-send-email-b48286@freescale.com>
 <20140210193948.GD18440@ld-irv-0074>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
To: 'Brian Norris' <computersforpeace@gmail.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20140210193948.GD18440@ld-irv-0074>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Id: linux-spi.vger.kernel.org

Hi Brian,

> -----Original Message-----
> From: Brian Norris [mailto:computersforpeace@gmail.com]
> Sent: Tuesday, February 11, 2014 3:40 AM
> To: Hou Zhiqiang-B48286
> Cc: linux-mtd@lists.infradead.org; linuxppc-dev@ozlabs.org; Wood Scott-
> B07421; Hu Mingkai-B21284; linux-spi@vger.kernel.org
> Subject: Re: [PATCH v2] mtd: m25p80: Make the name of mtd_info fixed
> 
> On Sun, Jan 26, 2014 at 02:16:43PM +0800, Hou Zhiqiang wrote:
> > To give spi flash layout using "mtdparts=..." in cmdline, we must give
> > mtd_info a fixed name,because the cmdlinepart's parser will match the
> > name given in cmdline with the mtd_info.
> >
> > Now, if use OF node, mtd_info's name will be spi->dev->name. It
> > consists of spi_master->bus_num, and the spi_master->bus_num maybe
> > dynamically fetched.
> > So, give the mtd_info a new fiexd name "name.cs", "name" is name of
> > spi_device_id and "cs" is chip-select in spi_dev.
> >
> > Signed-off-by: Hou Zhiqiang <b48286@freescale.com>
> > ---
> > v2:
> >  - add check for return value of function kasprintf.
> >  - whether the spi_master->bus_num is dynamical is determined by spi
> >    controller driver, and it can't be check in this driver. So, we can
> >    not initial the mtd_info's name by distinguishing the spi_master
> >    bus_num dynamically-allocated or not.
> 
> How about spi->master->bus_num < 0 ?
> 
In spi slave driver, we can not see this case. The spi->master->bus_num 
must be greater than 0, because before loading spi slave driver, the spi
controller driver will check spi->master->bus_num, if it is less than 0,
the spi controller driver will allocate a new bus_num dynamically. So it
is always greater than 0 in m25p80.c.

> >  drivers/mtd/devices/m25p80.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mtd/devices/m25p80.c
> > b/drivers/mtd/devices/m25p80.c index eb558e8..1f494d2 100644
> > --- a/drivers/mtd/devices/m25p80.c
> > +++ b/drivers/mtd/devices/m25p80.c
> > @@ -1011,8 +1011,12 @@ static int m25p_probe(struct spi_device *spi)
> >
> >  	if (data && data->name)
> >  		flash->mtd.name = data->name;
> > -	else
> > -		flash->mtd.name = dev_name(&spi->dev);
> > +	else {
> > +		flash->mtd.name = kasprintf(GFP_KERNEL, "%s.%d",
> > +				id->name, spi->chip_select);
> 
> I don't think this name is specific enough. What if there are more than
> one SPI controller? Then there could be one chip with the same chip-
> select. You probably still need to incorporate the SPI master somehow,
> even if it's not by using the bus number directly (because it's dynamic).
>
Yeah, you're right. Actually the bus_num is used to distinguish different
spi controller. If the controller driver give a dynamically-allocated
bus_num, yourself should take the risk to use mtdparts in command line.
I think, it is spi controller driver's responsibility to assign a
reasonable bus_num to make sure using command line mtdparts riskless, then
it is unnecessary to change mtdinfo's name.
 
> > +		if (!flash->mtd.name)
> > +			return -ENOMEM;
> > +	}
> >
> >  	flash->mtd.type = MTD_NORFLASH;
> >  	flash->mtd.writesize = 1;
> 
> Brian
> 

Zhiqiang Hou
