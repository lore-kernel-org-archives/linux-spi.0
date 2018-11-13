From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH 7/7] spi: bcm2835: Speed up FIFO access if fill level is
 known
Date: Tue, 13 Nov 2018 20:07:17 +0100 (CET)
Message-ID: <230536172.259102.1542136037433@email.ionos.de>
References: <807EBC97-54BD-49D5-86C8-3768FB4C0105@martin.sperl.org>
 <52205641.172367.1541849134970@email.ionos.de>
 <20181113080740.lrhfo656m7e4kb7a@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mathias Duckeck <m.duckeck-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
 linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Noralf Tronnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Frank Pavlic <f.pavlic-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20181113080740.lrhfo656m7e4kb7a-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
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

> Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> hat am 13. November 2018 um 09:07 geschrieben:
> 
> 
> On Sat, Nov 10, 2018 at 12:25:34PM +0100, Stefan Wahren wrote:
> > > On 08.11.2018, at 08:06, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> wrote:
> > > > +#define BCM2835_SPI_FIFO_SIZE		64
> > > > +#define BCM2835_SPI_FIFO_SIZE_3_4	48
> > 
> > I only have doubts about the naming FIFO_SIZE_3_4 because it describe
> > a fill level not a size.
> 
> Hm, it's three quarters of the FIFO's size, so seems sufficiently apt?

Just a thought because only from the define name i wouldn't think of three quarters first.
Since i don't have a better solution, please go on.
