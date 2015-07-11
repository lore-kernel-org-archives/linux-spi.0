From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH V2] dt: brcm,bcm2835-aux-spi: add binding documentation
 for new spi-bcm2835aux
Date: Fri, 10 Jul 2015 22:28:41 -0600
Message-ID: <55A09B79.9040109@wwwdotorg.org>
References: <1435229673-2214-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1435229673-2214-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 06/25/2015 04:54 AM, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Patch description? I'd suggest deriving this from the first paragraph in
the binding doc.

> diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt

> +The BCM2835 contains two forms of SPI master controller, one known simply as
> +SPI0, and the other known as the "Universal SPI Master"; part of the
> +auxiliary block. This binding applies to the SPI1/2 controller.

Rather than "SPI1/2", I'd say "this universal SPI master", since the
description of the two types of controller doesn't mention that SPI1/2
are the universal SPI master.

> +- reg: Should contain register location and length for the spi block
> +       as well as for the common aux block control

Sharing a reg entry between multiple devices almost always turns out to
be a mistake. At the very least, the drivers can't claim the region
since regions can't be claimed multiple times. Is there any way to avoid
this entirely?

If not, perhaps you need to create a separate driver to manage the
shared register block.
