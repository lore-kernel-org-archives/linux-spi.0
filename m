From: "yi li" <liyi.dev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: More on "SD-over-SPI with shared SPI bus"
Date: Fri, 10 Oct 2008 14:08:27 +0800
Message-ID: <a0e7fce50810092308w16d20017y1bb3ba810b6bc01e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Erwin,

You mentioned in your previous mail on August that, you have a patch
to make mmc_spi
share bus with other SPI devices. This is the latest mail I can find
on this topic.

>
> I have done this in a slightly different, rather simple way. I have
> added a new "transfer_end" callback function pointer to the spi_transfer
> structure. This function can have three return values:
>
> <0 ... stop spi message after the transfer
> 0 ... continue with next transfer
> 1 ... repeat current transfer
>
> If the transfer_end callback is not required, the function pointer must
> be set to NULL.
>
> I have modified the bitbang driver for this new functionality. In
> addition, the mmc_spi driver has been changed to make use of the
> callback function. It is necessary to pack all transfers that must be
> done without being interrupted into a single message. I have done a lot
> of testing with a SD card on a shared bus with a lot of other activity,
> and I couldn't see any problems.

I am wondering whether this patch has been finished? Is it possible to
release the patch for testing?
I am planning to implement similar thing, but I hope to base my work
on your patch.

Best Regards,

-Yi

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
