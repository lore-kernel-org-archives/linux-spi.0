From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH v2] spi: Add support for
	the	OpenCores SPI controller.
Date: Tue, 28 Apr 2009 13:15:32 +0200
Message-ID: <20090428111532.GA14422@avionic-design.de>
References: <200904041227.54687.david-b@pacbell.net>
	<1240916464-4187-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1240916464-4187-1-git-send-email-thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

* Thierry Reding wrote:
> This patch adds a platform device driver that supports the OpenCores SPI
> controller.
> 
> The driver expects two resources: an IORESOURCE_MEM resource defining the
> core's memory-mapped registers and an IORESOURCE_IRQ for the associated
> interrupt. It also requires a clock, "spi-master-clk", used to compute the
> clock divider.
> 
> Signed-off-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
[snip]

This second version is pretty much a rewrite. Some notes about the most
important changes:

  * uses per-chip states to allow more slaves to use the controller
    concurrently
  * rejects invalid device configurations during setup
  * rejects invalid per-message and per-transfer options
  * queues messages so that they can be processed one after another
      - this also provides for a way to handle power-management
  * omits the spioc.h (and with it the platform data structure):
      - uses the platform_device.id for the bus number
      - always uses 8 chipselects because that's the maximum that the core
        supports

I couldn't really find a way to implement per-transfer overrides for the
word size because the controller simply has no concept of word sizes. Is it
in such cases still necessary to hardwire the word size to 8 bits?

Thierry


------------------------------------------------------------------------------
Register Now & Save for Velocity, the Web Performance & Operations 
Conference from O'Reilly Media. Velocity features a full day of 
expert-led, hands-on workshops and two days of sessions from industry 
leaders in dedicated Performance & Operations tracks. Use code vel09scf 
and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
