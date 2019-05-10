From: Hoan <na-hoan-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835: Remove spi_alloc_master() error printing
Date: Fri, 10 May 2019 18:23:17 +0900
Message-ID: <a16cd122-8f30-d9d3-6774-bb6c25243f8c@jinso.co.jp>
References: <1557477738-20634-1-git-send-email-na-hoan@jinso.co.jp>
 <f8998234-1ab6-43e7-7dd8-859933b2179f@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <f8998234-1ab6-43e7-7dd8-859933b2179f-eS4NqCHxEME@public.gmane.org>
Content-Language: en-US
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

Dear Mr. Stefan!

On 2019/05/10 18:05, Stefan Wahren wrote:
> Hi,
>
> On 10.05.19 10:42, Nguyen An Hoan wrote:
>> From: Hoan Nguyen An <na-hoan-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
>>
>> Printing an error on memory allocation failure is unnecessary,
>> as the memory allocation core code already takes care of that.
>>
>> Signed-off-by: Hoan Nguyen An <na-hoan-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
> looks like more spi drivers are affected.
>
> Could you please take care at least of spi-bcm2835aux ?
Thanks! I have just updated it!


Thank You!
