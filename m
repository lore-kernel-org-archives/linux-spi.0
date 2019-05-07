From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] spi updates for v5.2
Date: Tue, 7 May 2019 08:08:50 -0700
Message-ID: <CAADWXX_k_D7=SPd=bi-=3EtBjeG6fe0EaTb4U4ZZgoOoRSub-Q@mail.gmail.com>
References: <20190506143301.GU14916@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190506143301.GU14916@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, May 6, 2019 at 7:33 AM Mark Brown <broonie@kernel.org> wrote:
>
> spi: Updates for v5.2

Hmm. Please be more careful. Commit 1dfbf334f123 ("spi: ep93xx:
Convert to use CS GPIO descriptors") caused a new warning because it
removed a "for ()" loop, but left the now unused variable 'i' around.

I fixed it up in the merge, because I hate warnings that may hide real
problems. But I also expect maintainers to check their warnings,
exactly because the normal build is supposed to have none. So a new
warning does stand out.

                    Linus
