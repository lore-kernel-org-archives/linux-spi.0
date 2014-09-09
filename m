From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] spi: davinci: add support for adding delay between
	word's transmission
Date: Tue, 9 Sep 2014 13:09:27 -0400
Message-ID: <540F3447.3020609@ti.com>
References: <1410278851-10783-1-git-send-email-grygorii.strashko@ti.com>
	<20140909165555.GD2601@sirena.org.uk>
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
In-Reply-To: <20140909165555.GD2601-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
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

On 09/09/2014 12:55 PM, Mark Brown wrote:
> On Tue, Sep 09, 2014 at 07:07:31PM +0300, Grygorii Strashko wrote:
>
>> - ti,spi-c2t-delay: Chip-select-active-to-transmit-start delay
>> 	(SPIDELAY.C2TDELAY)
>
>> - ti,spi-t2c-delay: Transmit-end-to-chip-select-inactive delay
>> 	(SPIDELAY.T2CDELAY)
>
> Now I look at these they look very much like the standard delay feature
> that the SPI subsystem has already - are they?
Mark,

As Grygorii explained in previous postings (reproduced below), these 
delays are handled by the SPI hardware on Keystone and affect the delay 
between successive word tranmssion and has nothing to do with the delay 
you are talking about. Isn't the standard delay you mention here is 
between successive packets send down to the lower level driver (in this 
case spi-davinci.c) ?

Murali

Below is timing diagram which shows, in general, how these new 
parameters affect on words transmission over Keystone/Davinci SPI bus:

              +-+ +-+ +-+ +-+ +-+                           +-+ +-+ +-+
SPI_CLK      | | | | | | | | | |                           | | | | | |
   +----------+ +-+ +-+ +-+ +-+ +---------------------------+ +-+ +-+ +-

SPI_SOMI/SIMO+-----------------+                           +-----------
   +----------+ word1           +---------------------------+word2
              +-----------------+                           +-----------
                                           WDELAY
                                          <--------->
                                         +           +
SPI_CS                                  |           |
   +----+                                +-----------+
        |                                |           |
        +-----+-----------------+--------+           +-----+------------
        |     |                 |        |           |     |
        +     +                 +        |           +     +
         <--->                   <------>             <--->
        C2TDELAY                 T2CDELAY            C2TDELAY

Where:
         WDELAY - Delay in between transmissions
	C2TDELAY - Chip-select-active-to-transmit-start-delay
	T2CDELAY - Transmit-end-to-chip-select-inactive-delay
