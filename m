From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 1/2 V2] spi/mmc_spi: SPI bus locking
	API, using mutex
Date: Thu, 18 Feb 2010 13:10:57 +0100
Message-ID: <20100218131057.40f9e623.eschwab@online.de>
References: <20100218124425.599c4d76.eschwab@online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org,
	vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Kumar Gala
	<galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, David Brownell
	<dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100218124425.599c4d76.eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

I integrated your changes in V2, I hope I did not miss anything.

On Wed, 17 Feb 2010 13:03:04 -0700
Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:

[...]
> spi_sync() and spi_sync_locked() are largely idenical.  Only
> difference is that spi_sync() needs to obtain the mutex.  Rename
> spi_sync() to __spi_sync() and add a 'get_lock' flag parameter.  Then
> make spi_sync() and spi_sync_locked() call __spi_sync() with the flag
> set appropriately.

I made the parameter 'bus_locked' instead of 'get_lock' because we
do not only get the lock but release it after use.


[...]
> > =A0extern int spi_setup(struct spi_device *spi);
> > =A0extern int spi_async(struct spi_device *spi, struct spi_message *mes=
sage);
> > +extern int
> > +spi_async_locked(struct spi_device *spi, struct spi_message *message);
> =

> Please keep return parameters and annotations on the same line as the
> function name (makes grep results more useful).  You can break lines
> between parameters.

Hm, the prototype for spi_alloc_master in the same file let me assume,
that this should be the style used in this header file. Normally, I =

wouldn't do a linebreak there, ever...

Something more important:

I have concerns on the use of the spin lock around the =

__spi_async() call, as Mike Frysinger already remarked.

Why do we 'need' this spin lock:
- by definition, spi_async can be called from any context
	"
	 * Context: any (irqs may be blocked, etc)
	 *
	 * This call may be used in_irq and other contexts which can't sleep,
	 * as well as from task contexts which can sleep.
	"
- we are not sure that spi_async isn't used reentrant (e.g. interrupt
  service routine and normal context
- __spi_async calls the master->transfer() function which is not required
  to be reentrant (or is it?)

But: This all is true for the original design, there seems to be no
protection against accidental reentrant use of spi_async().

Maybe we should check if there is any current call of spi_async() from
context that cannot sleep, and change the definition where it is allowed
to be called, if possible.

Regards
Ernst



---------------------------------------------------------------------------=
---
Download Intel&reg; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs =

proactively, and fine-tune applications for parallel performance. =

See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
