From: Michal Marek <mmarek@suse.com>
Subject: Re: [PATCH 0/2] Moving runnable code from Documentation (last 2
 patches)
Date: Sat, 1 Oct 2016 22:46:45 +0200
Message-ID: <57F020B5.4060704@suse.com>
References: <cover.1474912582.git.shuahkh@osg.samsung.com>
 <0f5557aa-23ad-c37c-6d97-13789c0b5726@osg.samsung.com>
 <20161001011044.70aefa33@lwn.net>
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
        linux-kbuild@vger.kernel.org, linux-spi@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuahkh@osg.samsung.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20161001011044.70aefa33@lwn.net>
Sender: linux-kbuild-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Dne 1.10.2016 v 09:10 Jonathan Corbet napsal(a):
> On Fri, 30 Sep 2016 07:57:51 -0600
> Shuah Khan <shuahkh@osg.samsung.com> wrote:
> 
>>> This patch series contains the last 2 patches to complete moving runnable
>>> code from Documentation to selftests, samples, and tools.
>>>
>>> The first patch moves blackfin gptimers-example to samples and removes
>>> CONFIG_BUILD_DOCSRC.
>>>
>>> The second one updates 00-INDEX files under Documentation to reflect the
>>> move of runnable code from Documentation.
>>>
>>> Shuah Khan (2):
>>>   samples: move blackfin gptimers-example from Documentation
>>>   Doc: update 00-INDEX files to reflect the runnable code move
>>>   
>>
>> Hi Jon and Michal,
>>
>> Do these patches look good to you? I can get these into 4.9-rc1
>> with your Ack.
> 
> Seems good to me.
> 
> Acked-by: Jonathan Corbet <corbet@lwn.net>

Likewise,

Acked-by: Michal Marek <mmarek@suse.com>

Michal

