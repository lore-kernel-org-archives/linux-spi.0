From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: add a bits_per_word to struct spi_board_info
Date: Wed, 8 Sep 2010 22:36:29 -0600
Message-ID: <AANLkTi=QgsQE_t0YT_-Me_nmB1Rdykx1UwM8E+zRt6kr@mail.gmail.com>
References: <20100909031827.GA10389@angua.secretlab.ca>
	<570796.22556.qm@web180308.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <570796.22556.qm-g47maUHHHF8P4eY3Ra60wvu2YVrzzGjVVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Sep 8, 2010 at 9:48 PM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> You know, in retrospect, I shouldn't have put
> most of those SPI device setup params into the
> board setup data.

Out of curiosity, what was the reasoning behind registering the spi
board info separately instead of passing it explicitly via the spi bus
driver's platform_data?  (I ask only because I'm unfamiliar with the
history).

> There's one which MUST be there: =A0polarity of
> the chip select line. =A0The rest seem like they
> could (and arguably should) all be handled by
> driver-specific params. =A0(Possible exception:
> clock rate, which sometimes matters even when
> chips are not selected).

Of course, CS polarity and clock rate are more representative of the
interconnection than of the device.  Regardless though, it should be
done in such a way that a properly behaved spi_driver cannot change
the initial .probe() conditions.

> At any rate, adding MORE driver-specific params
> (like bits-per-word) to board setup data seems
> like the wrong direction to go...

indeed!

g.

---------------------------------------------------------------------------=
---
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
