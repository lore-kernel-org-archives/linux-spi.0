From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: problem with converting from at91_spi to
	atmel_spi (AT91RM9200)
Date: Thu, 24 May 2007 09:31:43 -0700
Message-ID: <200705240931.43663.david-b@pacbell.net>
References: <20070523143456.15fc49ab@newbox>
	<200705230906.13353.david-b@pacbell.net>
	<20070524133646.62bbc386@dhcp-255-175.norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Bill Gatliff <bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Nicolas Ferre <nicolas.ferre-XEyKDsrmbOsS+FvcfC7Uqw@public.gmane.org>, andrew-eS41wJS13H5l57MIdRCFDg@public.gmane.org
To: Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070524133646.62bbc386-RzfXdsu3MTOUA/xf2v/QOMGzbamoMwWuEvhb3Hwu1Ks@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thursday 24 May 2007, Haavard Skinnemoen wrote:
> On Wed, 23 May 2007 09:06:12 -0700
> David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> > On Wednesday 23 May 2007, Ivan Kuten wrote:
> > > 	
> > >                 .chip_select    = 0,
> > 
> > Chipselect zero ... I've had one report that this driver has some issues
> > on that chipselect.  There seem to be two errata in conflict here:
> > ...
> 
> Neither of these should cause any problems for the atmel_spi driver
> since it manages chip selects using gpio and sets the MODFDIS bit in MR
> to disable mode fault detection (I actually ran into both erratas myself
> while developing the driver.)

Yet, I got the report (at91rm9200 specific).  Bill?  (I remember
MODFDIS acting oddly, non-rm9200, but forget the details.)  And in
any case there seem to be other folk reporting rm9200 + dataflash
issues ... while mtd_dataflash doesn't seem to be at fault.  So
maybe that combination of errata isn't the issue, but something
else is making the problem. 


> > I've CC'd the relevant folk from Atmel.  Seems that maybe rm9200
> > needs to have a special case whereby chipselect zero is managed
> > by the hardware despite the first erratum.  And maybe that because
> > of that erratum, the DMA chaining needs to be made to work... else
> > root-on-dataflash won't behave.  (Or some other workaround.)
> 
> Hmm...I don't think I understand why DMA chaining will help in this
> case. Could you explain a bit more?

It *might* help -- by keeping the transfer buffer busy enough that
the "auto-deselect" erratum needn't kick in with some basic request
and response protocol operations.

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
