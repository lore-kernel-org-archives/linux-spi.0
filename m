From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/1] ARM PL022 SSP/SPI driver v2
Date: Mon, 1 Jun 2009 14:01:26 +0200
Message-ID: <63386a3d0906010501l1de3cfeah74390cf8a3fac8bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Alessandro Rubini <rubini-list-kaDoWcXyVrEAvxtiuMwx3w@public.gmane.org>,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org,
	Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

ChangeLog v1->v2:

* Moved #define comments together with the #define on one
  line where possible. Sometimes I had to go from using tabs
  to using a few spaces to do this, but it works out.

* Replaced FOO_STATE with STATE_FOO everywhere using regexp
  s/\([A-Z]+\)_STATE/STATE_\1/g, same for CPSDVR, SCR MAX and
  MIN defines, same with {READING|WRITING}_{U8|U16|U32|NULL}.

* Align struct member with TAB.

* Return IRQ_NONE immediately in the interrupt handler when
  there is no IRQ source bit set, removing a large chunk of
  excess IRQ handling indentation.

* Added "(EXPERIMENTAL)" to the config description.

* Removed check for children PM status in suspend code. The
  device model makes sure that any suspend() hooks in the
  children are called and return OK anyway, so this was
  entirely unnecessary.

* Remove __initdata tag from AMBA PrimeCell IDs, it could
  potentially be referenced at runtime.

* Forward-declare struct device in the pl022.h file instead
  of including <device.h>.

* Fix capitalization Tx Rx -> TX RX globally.

* spi_set_ctldata(spi, NULL); in pl022_cleanup().

Yours,
Linus Walleij

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
