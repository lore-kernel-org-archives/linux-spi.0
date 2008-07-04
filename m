From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2 3/5] of-bindings: Add binding
	documentation for SPI	bussesand devices
Date: Thu, 3 Jul 2008 22:05:50 -0600
Message-ID: <20080704040550.GG12945@secretlab.ca>
References: <20080703005749.26187.71719.stgit@trillian.secretlab.ca>
	<20080703010308.26187.23037.stgit@trillian.secretlab.ca>
	<58A20A281BAF1047B4EAE68DE5C0BDC2010121B9@zch01exm21.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org,
	fabrizio.garetto-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Chen Gong <G.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <58A20A281BAF1047B4EAE68DE5C0BDC2010121B9-bKEhWGtIRULiD3AT8lUqWFjVikpgYyvb5NbjCUgZEJk@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jul 04, 2008 at 11:59:07AM +0800, Chen Gong wrote:
> > +    - reg             - (required) chip select address of device.
> > +    - compatible      - (required) name of SPI device 
> > following generic names
> > +			recommended practice
> > +    - max-speed       - (required) Maximum SPI clocking 
> > speed of device in Hz
> > +    - spi,cpol        - (optional) Device requires inverse 
> > clock polarity
> > +    - spi,cpha        - (optional) Device requires shifted 
> > clock phase
> > +    - linux,modalias  - (optional, Linux specific) Force 
> > binding of SPI device
> > +			to a particular spi_device driver.  
> > Useful for changing
> > +			driver binding between spidev and a 
> > kernel SPI driver.
> > +
> 
> How about adding a "model" property to describe actual devie type.
> Such as using a "sst25vf040b" device with spi-interface, we can
> use model="sst25vf040b" to describe it.

That's what "compatible" is for.  First value in the compatible list is
the actual device, followed by devices it is compatible with.  In
your particular example, the value would be "sst,sst25vf040b" so that it
follows device tree conventions.

g.

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
