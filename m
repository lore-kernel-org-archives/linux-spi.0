From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH] devicetree/bindings: Add binding for micron n25q512a
 memory
Date: Tue, 8 Jul 2014 20:53:38 -0500
Message-ID: <1404870818.21434.291.camel@snotra.buserror.net>
References: <1404382376-3115-1-git-send-email-Priyanka.Jain@freescale.com>
	 <1404425400.21434.89.camel@snotra.buserror.net>
	 <b7e1d3bf1675492585121d9e7950f05a@BLUPR03MB135.namprd03.prod.outlook.com>
	 <1404768354.21434.191.camel@snotra.buserror.net>
	 <a9ac5cbcdb554bedbda35594740e320d@BLUPR03MB135.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Jain Priyanka-B32167 <Priyanka.Jain-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <a9ac5cbcdb554bedbda35594740e320d-GeMU99GfrruZBIYY9rwZPeO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, 2014-07-07 at 23:41 -0500, Jain Priyanka-B32167 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, July 08, 2014 2:56 AM
> > To: Jain Priyanka-B32167
> > Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-
> > spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> > Subject: Re: [PATCH] devicetree/bindings: Add binding for micron n25q512a
> > memory
> > 
> > On Thu, 2014-07-03 at 23:08 -0500, Jain Priyanka-B32167 wrote:
> > >
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Friday, July 04, 2014 3:40 AM
> > > > To: Jain Priyanka-B32167
> > > > Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org;
> > > > linux- spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> > > > Subject: Re: [PATCH] devicetree/bindings: Add binding for micron
> > > > n25q512a memory
> > > >
> > > > On Thu, 2014-07-03 at 15:42 +0530, Priyanka Jain wrote:
> > > > > -Micron n25q512a memory is supported by m25p80 driver.
> > > > >  Add compatible field required to support n25q512a in m25p80.txt
> > > > > -Add micron to the vendor-prefixes.txt file
> > > > >
> > > > > Signed-off-by: Priyanka Jain <Priyanka.Jain-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/mtd/m25p80.txt   |    1 +
> > > > >  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
> > > > >  2 files changed, 2 insertions(+), 0 deletions(-)
> > > >
> > > > Why did you send this to the ppc list but not the spi or mtd lists?
> > > >
> > > [Jain Priyanka-B32167] Sorry, I missed that
> > > > I'm having a hard time following the flow of how these SPI devices
> > > > get bound -- is the compatible involved at all?  I don't see this
> > > > string (with vendor prefix included) in the driver.  I do see a
> > > > table that contains what looks like device IDs.  If the device can
> > > > report its id, shouldn't we rely on that rather than device tree
> > compatible?
> > > >
> > > > -Scott
> > > [Jain Priyanka-B32167]
> > > Spi driver has a check to device name corresponding to device-id and
> > compare to what is passed in dts string.
> > 
> > Please go into more detail.  I don't see where the string
> > "micron,n25q512a" appears in the current kernel.  I do see "n25q512a",
> > but how does that compare successfully with the version of the string
> > that has a vendor compatible?
> > 
> > Again, is there a device ID that can be read at runtime?  Is there a
> > compatible string that represents a common programming interface?
> [Jain Priyanka-B32167] 
>
> Spi driver (of_register_spi_devices()) search for compatible string in
> device-tree. It selects the flash device driver based on the compatible
> string (n25q512a). This compatible string is essential, else device
> probe wont continue.  Then Device-id of flash is read at runtime in
> probe and compared with the corresponding device-id of flash
> (n25q512a). Device-id (maintained as first element in INFO string in
> spi_nor_ids[] in drivers/mtd/spi-nor/spi-nor.c file)

By "device id" I'm talking about 0x20bb20, not "n25q512a".  Where does
that come from?

> Only if both device-ids match, the device is taken as successfully
> detected. Regarding vendor "micron", you are right currently the vendor
> information is not maintained as such in device-id, but the convention
> that is followed for compatible string is "vendor-id, device-id"

Is there going to be a patch to the driver to accept the string with
vendor id?

> > > New checkpatch script search for exact string match in binding folder.
> > So, I have added this in example.
> > 
> > That check has a lot of false positives when it comes to compatible
> > strings for specific chips that don't need to be specifically mentioned
> > in a more generic binding.
> > 
> > -Scott
> > 
> [Jain Priyanka-B32167] Even though "micron,n25q512a" is in sync with
> binding mentioned in "
> Documentation/devicetree/bindings/mtd/m25p80.txt   ", I have to add
> this as an a example, just to avoid checkpatch error. What should be
> the approach going forward: Should such checkpatch warnings be ignored?

They shouldn't be ignored nor blindly remedied.  You should look at the
message and decide whether a binding is needed and whether it is
present.  There probably should be a binding here, but I don't have
enough information to say whether it should be specific to n25q512a or
if spi nor can be described more generically.

-Scott


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
