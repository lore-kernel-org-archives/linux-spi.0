From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: Re: [PATCH 0/2] Moving runnable code from Documentation (last 2
 patches)
Date: Fri, 30 Sep 2016 07:57:51 -0600
Message-ID: <0f5557aa-23ad-c37c-6d97-13789c0b5726@osg.samsung.com>
References: <cover.1474912582.git.shuahkh@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: akpm@linux-foundation.org, keescook@chromium.org,
        dan.j.williams@intel.com, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, jpoimboe@redhat.com, tj@kernel.org,
        aryabinin@virtuozzo.com, nikolay@cumulusnetworks.com,
        dvyukov@google.com, rostedt@goodmis.org, olof@lixom.net,
        arnd@arndb.de, hans.verkuil@cisco.com, nab@linux-iscsi.org,
        mchehab@kernel.org, broonie@kernel.org, tglx@linutronix.de,
        ecree@solarflare.com, davem@davemloft.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-spi@vger.kernel.org,
        Shuah Khan <shuahkh@osg.samsung.com>
To: corbet@lwn.net, mmarek@suse.com
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <cover.1474912582.git.shuahkh@osg.samsung.com>
Sender: linux-kbuild-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 09/26/2016 12:40 PM, Shuah Khan wrote:
> This patch series contains the last 2 patches to complete moving runnable
> code from Documentation to selftests, samples, and tools.
> 
> The first patch moves blackfin gptimers-example to samples and removes
> CONFIG_BUILD_DOCSRC.
> 
> The second one updates 00-INDEX files under Documentation to reflect the
> move of runnable code from Documentation.
> 
> Shuah Khan (2):
>   samples: move blackfin gptimers-example from Documentation
>   Doc: update 00-INDEX files to reflect the runnable code move
> 

Hi Jon and Michal,

Do these patches look good to you? I can get these into 4.9-rc1
with your Ack.

thanks,
-- Shuah

