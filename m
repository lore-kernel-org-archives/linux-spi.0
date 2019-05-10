From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835aux: Remove spi_alloc_master() error printing
Date: Fri, 10 May 2019 12:12:26 +0200
Message-ID: <C67428EF-6EC9-4655-B2FA-B562402E4AAE@sperl.org>
References: <1557480060-15311-1-git-send-email-na-hoan@jinso.co.jp>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
 linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
 linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nguyen An Hoan <na-hoan-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1557480060-15311-1-git-send-email-na-hoan-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
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


> On 10.05.2019, at 11:21, Nguyen An Hoan <na-hoan-HEF513clHfp3+QwDJ9on6Q@public.gmane.org> wrote:
> 
> From: Hoan Nguyen An <na-hoan-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
> 
> Printing an error on memory allocation failure is unnecessary,
> as the memory allocation core code already takes care of that.
> 
> Signed-off-by: Hoan Nguyen An <na-hoan-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Reviewed-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
