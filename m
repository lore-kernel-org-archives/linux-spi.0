From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v2] spi: Add support for the
	OpenCores SPI controller.
Date: Tue, 28 Apr 2009 04:58:22 -0700
Message-ID: <200904280458.23018.david-b@pacbell.net>
References: <200904041227.54687.david-b@pacbell.net>
	<1240916464-4187-1-git-send-email-thierry.reding@avionic-design.de>
	<20090428111532.GA14422@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20090428111532.GA14422-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
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

On Tuesday 28 April 2009, Thierry Reding wrote:
> This second version is pretty much a rewrite.

That happens sometimes...


> Some notes about the most =

> important changes:
> =

> =A0 * uses per-chip states to allow more slaves to use the controller
> =A0 =A0 concurrently
> =A0 * rejects invalid device configurations during setup
> =A0 * rejects invalid per-message and per-transfer options
> =A0 * queues messages so that they can be processed one after another
> =A0 =A0 =A0 - this also provides for a way to handle power-management
> =A0 * omits the spioc.h (and with it the platform data structure):
> =A0 =A0 =A0 - uses the platform_device.id for the bus number
> =A0 =A0 =A0 - always uses 8 chipselects because that's the maximum that t=
he core
> =A0 =A0 =A0 =A0 supports

All that sounds good.

 =

> I couldn't really find a way to implement per-transfer overrides for the
> word size because the controller simply has no concept of word sizes. Is =
it
> in such cases still necessary to hardwire the word size to 8 bits?

Is this the http://www.opencores.org/?do=3Dproject&who=3Dspi core?
Its summary says "Variable length of transfer word up to 32 bits";
does that mean "configurable when core is synthesized" instead of
truly "variable"?

---------------------------------------------------------------------------=
---
Register Now & Save for Velocity, the Web Performance & Operations =

Conference from O'Reilly Media. Velocity features a full day of =

expert-led, hands-on workshops and two days of sessions from industry =

leaders in dedicated Performance & Operations tracks. Use code vel09scf =

and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
