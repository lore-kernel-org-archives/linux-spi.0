From: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Subject: Re: [PATCH] spi/spi-altera: Allow to explicitely override bus
 number via dts
Date: Wed, 1 Feb 2012 14:35:58 +0000
Message-ID: <20120201143558.GF13723@sirena.org.uk>
References: <1328025246-23450-1-git-send-email-tklauser@distanz.ch>
 <20120201135524.GD13723@sirena.org.uk>
 <CAMVnO+kWX=NYi+YU9H5nRc9UksCJLQUi-_Kj9UASwoiqZj9tGA@mail.gmail.com>
 <20120201140838.GE13723@sirena.org.uk>
 <CAMVnO+m5DTYeK9mHcciqU-y7HGP-d9FXWkvTV4ZJJLTRqjK7LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
 devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
 Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
To: Frederic LAMBERT <frdrc66-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMVnO+m5DTYeK9mHcciqU-y7HGP-d9FXWkvTV4ZJJLTRqjK7LQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Feb 01, 2012 at 03:25:33PM +0100, Frederic LAMBERT wrote:

> > > Because this bus number is used to create the device name on
> > > /sys/bus/spi/..., name that the user app must know to work with.

> > Why must the user application know this?  What is missing to allow the
> > application to discover an appropriate device to work with automatically?

> Good question. I have a nvSRAM that I access using the AT25 driver, and I
> don't know how access it without its /sys/bus/ name. If there is another
> way, it is worse to consider it.

For this I'd expect the application to be able to enumerate all the SPI
devices and offer the user a selection of those with the appropriate
driver bound (though I can see that simple scripts might not have
bothered).
