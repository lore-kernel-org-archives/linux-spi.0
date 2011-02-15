From: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Subject: Re: [PATCH v9] spi: New driver for Altera SPI
Date: Tue, 15 Feb 2011 15:04:49 +0800
Message-ID: <4D5A2591.5090901@wytron.com.tw>
References: <1297142509-20158-1-git-send-email-thomas@wytron.com.tw>
	<1297649443-11491-1-git-send-email-thomas@wytron.com.tw>
	<4D58917E.9050408@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Ryan Mallon <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <4D58917E.9050408-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>
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

Dear Ryan,

On 02/14/2011 10:20 AM, Ryan Mallon wrote:
> On 02/14/2011 03:10 PM, Thomas Chou wrote:
>> This patch adds a new SPI driver to support the Altera SOPC Builder
>> SPI component. It uses the bitbanging library.
>>
>> Signed-off-by: Thomas Chou<thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
>> ---
>
>> +struct altera_spi {
>> +	/* bitbang has to be first */
>> +	struct spi_bitbang bitbang;
>
> Is this still true? I had a quick look and can't see anything which
> relies on spi_bitbang being the first entry. Things like this should be
> using container_of so that position in the struct is irrelevant.
>
> ~Ryan
>

Yes, sadly true. This is due to the implementation of the bitbanging 
library, spi_bitbang.c, which assumes the struct spi_bitbang is the 
first of drvdata. Though it could be changed in the future (beyond this 
little driver), every bitbanging library user has to follow this for now.

Best regards,
Thomas
