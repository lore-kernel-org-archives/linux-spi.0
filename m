From: Illia Smyrnov <x0194613-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: omap2-mcspi: Add FIFO buffer support
Date: Tue, 11 Jun 2013 20:09:27 +0300
Message-ID: <51B759C7.7080806@ti.com>
References: <1370432398-7796-1-git-send-email-illia.smyrnov@ti.com>
	<1370432398-7796-3-git-send-email-illia.smyrnov@ti.com>
	<20130605120346.GZ31367@sirena.org.uk> <51B05FB8.6050903@ti.com>
	<20130606103032.GR31367@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>,
	Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Illia Smyrnov <illia.smyrnov-l0cyMroinI0@public.gmane.org>, Greg,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130606103032.GR31367-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 06/06/2013 01:30 PM, Mark Brown wrote:
> On Thu, Jun 06, 2013 at 01:08:56PM +0300, Illia Smyrnov wrote:
>> On 06/05/2013 03:03 PM, Mark Brown wrote:
>
>>> Why is this defined for slaves?  Surely the size of the FIFO in the
>>> controller is a property of the controller not the slave?
>
>> According to OMAP TRM [1] the FIFO buffer can be used by only one
>> channel at a time. If several channels are selected and several FIFO
>> enable bit fields are set to 1, the controller forces the buffer not
>> to be used.
>
> The controller ought to be able to figure this out for itself.  As a
> first pass just grabbing the FIFO on a first come first served basis
> will probably work well most of the time, the device would have to be
> very active for it to constantly be doing transfers on all channels.
>
> If there's more contention than that we probably ought to be looking at
> how we handle this in general, it seems like we'd have more problems
> than just the FIFO to worry about.
>
>> If there are several slaves on the controller we must select which
>> of slaves will use the FIFO for SPI transfers. Also, optimal FIFO
>
> A single controller is only going to be able to talk to one slave at
> once, everything on the bus except chip select is shared.
>
>> size is heavily dependent of the SPI transfers length specific for
>> certain slave.
>
> The transfer length doesn't seem like something that we want to be
> encoding in DT, particularly not indirectly - it is obviously readily
> available at runtime, variable during runtime (eg, firmware download may
> do large transfers on a device that only does small transfers most of
> the time) and is something that updates to the drivers could change.

I sent patches for v2 of the MCSPI FIFO support implementation. In this 
version driver will calculate the largest possible FIFO buffer size for 
each SPI transfer.
Also FIFO could be enabled by setting up parameter in the MCSPI 
controller (master) DT node.

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
