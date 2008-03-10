From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: spidev question
Date: Mon, 10 Mar 2008 12:00:44 -0800
Message-ID: <200803101300.44267.david-b@pacbell.net>
References: <1205178415.29669.119.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1205178415.29669.119.camel-/EMGr9iCeazgSi9v3i4K4Pmbkio/vSLMs0AfqQuZ5sE@public.gmane.org>
Content-Disposition: inline
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

On Monday 10 March 2008, Joakim Tjernlund wrote:
> Trying to make sense of spidev. We have 5 spi devices on the
> same spi bus and I am trying to use different word sizes for some of the
> devices.
> 
> I open 5 diffrent /dev/spidev0.x where x=0..4 and for
> each fd returned I do:
>  ioctl(fd, SPI_IOC_WR_BITS_PER_WORD, &bits);

That is, something like:

	fd[x] = open("/dev/spidev0.x", O_RDWR);
	ioctl(fd[x], SPI_IOC_WR_BITS_PER_WORD, &bits[x]);

Each device should have its own file descriptor.


> bits is either 8 or 16.
> However, it seems that the last ioctl "wins", all spi transactions
> appears to used the last setting, thats is, the ioctl appears to be
> for the controller, not the spi slave I am talking to.

Sounds like a bug in the controller driver, if you're properly
getting a file descriptor per device...


> This does not make sense to me, I figured I could set bits_per_word(and
> max speed too) for each slave. Can anyone tell me how spidev is supposed
> to work? It is quite possible that I got a problem in spi HW driver that
> fools me somehow.

Absolutely.  Each device has a variety of individual characteristics,
like speed, bits per word, mode, and so on.  That's why they're stored
in the spi_device rather than the controller

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
