From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3] spi: davinci: add support for adding delay between
	word's transmissions
Date: Mon, 15 Sep 2014 16:06:49 +0300
Message-ID: <5416E469.3020806@ti.com>
References: <1410536892-22775-1-git-send-email-grygorii.strashko@ti.com>
	<20140913160628.GF7960@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
In-Reply-To: <20140913160628.GF7960-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
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

On 09/13/2014 07:06 PM, Mark Brown wrote:
> On Fri, Sep 12, 2014 at 06:48:12PM +0300, Grygorii Strashko wrote:
>> From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
>>
>> This patch adds ability to configure delay between transmission of
>> words over SPI bus if it's required by SPI slave devices.
> 
> This is fine but it doesn't appear to apply against current code.  Can
> you please check and resend?
> 

This one should be applied without conflicts on top of
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
branch: for-next

since you've applied the patch:
"[PATCH] spi: davinci: request cs_gpio's from probe"
http://www.spinics.net/lists/linux-spi/msg01811.html

I have to mention about this dependency, sorry for that.

Regards,
-grygorii
