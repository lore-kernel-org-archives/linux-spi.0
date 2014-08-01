From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/2] spi: davinci: add support to configure gpio cs
	through dt
Date: Fri, 1 Aug 2014 21:20:52 +0300
Message-ID: <53DBDA84.5010405@ti.com>
References: <1406911233-18999-1-git-send-email-grygorii.strashko@ti.com>
	<1406911233-18999-2-git-send-email-grygorii.strashko@ti.com>
	<20140801172620.GA30458@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
        Ian Campbell
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
        <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring
	<robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20140801172620.GA30458-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 08/01/2014 08:26 PM, Mark Brown wrote:
> On Fri, Aug 01, 2014 at 07:40:32PM +0300, Grygorii Strashko wrote:
>> From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
>>
>> Currently driver supports only configuration of GPIO CS through
>> platform data. This patch enhances the driver to configure GPIO
>> CS through DT. Also update the DT binding documentation to
>> reflect the availability of cs-gpios.
>
> Please submit an incremental patch with whatever the changes were from
> the version of this that I applied already.
>

This series is based on top of:
"[PATCH 1/2] spi: davinci: fix to support more than 2 chip selects"
http://www.spinics.net/lists/linux-spi/msg01447.html

Sorry, I've forgot to mention this in cover letter.
Is that what you mean?

regards,
-grygorii
