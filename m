From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Patch submission for fixing a bug in the
	SPIDEV driver.
Date: Tue, 7 Apr 2009 14:13:32 -0700
Message-ID: <200904071413.32917.david-b@pacbell.net>
References: <51D9710FF5643747BB605F97B8DE56CD02773126@STEGOSAURE.adetel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: LEMERCIER =?iso-8859-1?q?Gr=E9gory?= <glemercier-zjFYp9kwZlmZox4op4iWzw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <51D9710FF5643747BB605F97B8DE56CD02773126-60eonUy6E0Ou6pEdMXsbNRL4W9x8LtSr@public.gmane.org>
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

On Tuesday 07 April 2009, LEMERCIER Gr=E9gory wrote:
> When using the SPIDEV driver from the kernel, I found out that
> there is a bug that occurs when sending words of width larger
> than 8 bits. The buffer copy from Userspace will only copy =

> "number of words" bytes where it should actually copy
> "number of words * sizeof(word)" bytes.

On closer examination ... <linux/spi/spidev.h> clearly
specifies that this value is in bytes.  So, not a bug
in the kernel, just in your userspace code.

As a rule, you should expect buffers to be described to
any OS using byte lengths; anything else is unusual.

- Dave

/**
 * struct spi_ioc_transfer - describes a single SPI transfer
 * @tx_buf: Holds pointer to userspace buffer with transmit data, or null.
 *	If no data is provided, zeroes are shifted out.
 * @rx_buf: Holds pointer to userspace buffer for receive data, or null.
 * @len: Length of tx and rx buffers, in bytes.
 * ...








---------------------------------------------------------------------------=
---
This SF.net email is sponsored by:
High Quality Requirements in a Collaborative Environment.
Download a free trial of Rational Requirements Composer Now!
http://p.sf.net/sfu/www-ibm-com
