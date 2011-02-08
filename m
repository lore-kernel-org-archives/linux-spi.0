From: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Subject: Re: [PATCH v7] spi: New driver for Altera SPI
Date: Tue, 08 Feb 2011 10:43:14 +0800
Message-ID: <4D50ADC2.9060304@wytron.com.tw>
References: <20110203173430.GC6180@angua.secretlab.ca>	<1296914523-13740-1-git-send-email-thomas@wytron.com.tw>
	<87aai8zzd1.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <87aai8zzd1.fsf-uXGAPMMVk8amE9MCos8gUmSdvHPH+/yF@public.gmane.org>
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

On 02/07/2011 04:23 AM, Peter Korsgaard wrote:
>>>>>> "Thomas" == Thomas Chou<thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>  writes:
>
> Hi,
>
>   Thomas>  +++ b/drivers/spi/Kconfig
>   Thomas>  @@ -53,6 +53,13 @@ if SPI_MASTER
>
>   Thomas>   comment "SPI Master Controller Drivers"
>
>   Thomas>  +config SPI_ALTERA
>   Thomas>  +	tristate "Altera SPI Controller"
>   Thomas>  +	default n
>
> 'n' is the default anyway, so no need for this line.
>
Hi Peter,

Thanks. I will remove them.

- Thomas
