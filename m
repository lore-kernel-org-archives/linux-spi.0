From: Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
Subject: Re: [PATCH v2] spi: add OpenCores tiny SPI driver
Date: Fri, 21 Jan 2011 13:27:29 +0100
Message-ID: <1295612849.23825.26.camel@needafix>
References: <1294800109-31603-1-git-send-email-thomas@wytron.com.tw>
	<1295249542-26743-1-git-send-email-thomas@wytron.com.tw>
	<20110120165430.GA24445@angua.secretlab.ca>
	<4D38AAEB.7020308@wytron.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <4D38AAEB.7020308-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi,

> 
> >> +#ifdef CONFIG_OF
> >> +static struct of_device_id oc_tiny_spi_match[] = {
> >> +	{
> >> +		.compatible = "opencores,oc_tiny_spi",
> >
> > If this is a soft core, then there should be a version number of some
> > sort on the compatible value.  Also, please use dash '-' instead of
> > underscore '_' in compatible values.  Also, for all of these new
> > bindings, they need to be documented.  Please add documentation to
> > Documentation/powerpc/dts-bindings (yes, I know, this is not
> > for powerpc, but that is the established directory.  I'll move it to a
> > better location soon).
> >

It would be nice to use the same name for the OpenCores project and the
device tree identifier, and since "opencores" is already in the name,
the "oc_" bit is superfluous anyway.  I'd suggest "opencores,tiny-spi"
in order to match your OpenCores project name.

Versioning of OpenCores cores is not sorted yet.  In order to avoid
clashing with the versioning/naming scheme that's decided on, please
just use a neutral version number for now (especially as your core is so
new).  e.g. "opencores,tiny-spi-0"

/Jonas
