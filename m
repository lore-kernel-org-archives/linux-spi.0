From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] spi updates for v5.2
Date: Mon, 6 May 2019 19:34:29 -0700
Message-ID: <CAHk-=whLZMe5kNpNMnhh5oVHFKNv7Um4tBS+rH=kLvM+CWzzxw@mail.gmail.com>
References: <20190506143301.GU14916@sirena.org.uk> <CAADWXX_MqtZ6RxS2zEVmHtKrjqigiNzdSe5qVwBVvfVU6dxJRQ@mail.gmail.com>
 <20190507021853.GY14916@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190507021853.GY14916@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, May 6, 2019 at 7:19 PM Mark Brown <broonie@kernel.org> wrote:
> >
> >     dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
>
> That looks like it's a fail on validation of the kernel.org bit of
> things which I have no control over and which purposely doesn't
> advertise DKIM stuff in the hope that people will actually be able to
> send mail from non-kernel.org mail servers.

Looking around, I think you're right, and it's probably not actually
the DKIM thing that causes problems.

Because yes, kernel.org dmarc will just say "ignore".

So I think it's just google that still doesn't like sirena.org.uk.
Iirc, that's happened before, no?

                   Linus
