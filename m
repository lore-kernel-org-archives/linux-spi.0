From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/3] of_spi: add generic binding support to specify ncs
 gpio in the slave
Date: Mon, 30 Jan 2012 11:54:58 -0700
Message-ID: <20120130185458.GO28397@ponder.secretlab.ca>
References: <1327937271-23668-1-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
 devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1327937271-23668-1-git-send-email-plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
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

On Mon, Jan 30, 2012 at 04:27:49PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> This will allow to use gpio for chip select with no modification in the
> driver binding
> 
> When use the ncs-gpio, the gpio number will be passed via the controller_data
> and the number of chip select will automatically increased.
> 
> When a spi master have only gpio chip select and is probe via dt check the
> number of chip select only when adding slave.
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
> Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> ---
>  Documentation/devicetree/bindings/spi/spi-bus.txt |    9 ++++++-
>  drivers/of/of_spi.c                               |   27 ++++++++++++++------
>  drivers/spi/spi.c                                 |    2 +-
>  3 files changed, 28 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
> index e782add..1dccf35 100644
> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
> @@ -21,9 +21,16 @@ assumption that board specific platform code will be used to manage
>  chip selects.  Individual drivers can define additional properties to
>  support describing the chip select layout.
>  
> +If a gpio a specified to the SPI slave and no hardware chip select is present
> +the reg property #address-cells and #size-cells are not needed.
> +
> +When use the ncs-gpio the gpio number will be passed via the controller_data
> +and the number of chip select will automatically increased.
> +
>  SPI slave nodes must be children of the SPI master node and can
>  contain the following properties.
> -- reg             - (required) chip select address of device.
> +- reg             - (required if no ncs-gpio) chip select address of device.
> +- ncs-gpio        - (required if no reg) chip select gpio of device.

There is already precedence for using gpios for chip selects.  The slave device
nodes remain as they are and it is the responsibility of the spi bus node
to have a gpios property with a list of SS gpios.  The order of the gpios
property should match the 'reg' address numbering of the child node.

I don't like the idea of having multiple bindings for the slave address of
the spi device (reg or ncs-gpio)

What I want to see is generic SS helper code that spi bus drivers
default to and correctly implement parsing of chip select gpios.

I'm not going to apply this patch.

g.
