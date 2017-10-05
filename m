From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] spi: spreadtrum adi: add hwspinlock dependency
Date: Thu, 5 Oct 2017 22:40:11 +0200
Message-ID: <CAK8P3a0gh05qL8ez0mmPB-UCcWQmyHGMvU-XKgKCQPNGAcFJ4w@mail.gmail.com>
References: <20171005121129.531046-1-arnd@arndb.de> <20171005122244.6avlzy6vl44326c4@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Baolin Wang <baolin.wang@spreadtrum.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171005122244.6avlzy6vl44326c4@sirena.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Oct 5, 2017 at 2:22 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Oct 05, 2017 at 02:11:17PM +0200, Arnd Bergmann wrote:
>
>> This adds a hard Kconfig dependency on HWSPINLOCK, which is the
>> simplest solution since we don't care about building for the case
>> without HWSPINLOCK.
>
> Given that there are stubs for HWSPINLOCK it'd be good to also have an
> || COMPILE_TEST in there, otherwise what's the point in the stubs?

As far as I'm concerned, we can remove those stubs, it's easy enough
to compile-test with hwspinlock enabled, and the existing in-kernel
users all require hwspinlock anyway.

I've sent a second version now, please pick whichever you prefer.

     Arnd
